docker-compose.exe down
$startingDir = Get-Location
$templateNginx = ".\src\nginx.conf"
$genNginx = ".\src\nginx.generated.conf"
Copy-Item $templateNginx $genNginx -Force
# Parse the .env file into a hashtable
$dotEnv = @{ }
Get-Content ".\.env" | Where-Object { $_.length -gt 0 } | Where-Object { !$_.StartsWith("#") } | ForEach-Object {
    $var = $_.Split('=', 2).Trim()
    [void]$dotEnv.Add($var[0], $var[1])
}
# Encoded token stuff
$Content1 = get-content ".\src\person.json"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($Content1)
$jwt = [System.Convert]::ToBase64String($Bytes)
$dotEnv.Add("JWT", $jwt)
# Iterate through the hashtable and replace '${env}' with equivalent value inside of the nginx conf
# Looping a Get-Content (cat in *nix) along with Set-Content is messy, but its fine for small files
foreach ($key in $dotEnv.Keys) {
    $val = $dotEnv[$key]
    if ($val -ne "") {
        ((Get-Content -path $genNginx -Raw) -replace "\`${$key}", $val) | Set-Content -Path $genNginx
    }
}

# build them images
if ($dotEnv["BACKEND_FOLDER"] -ne "") {
    cd -Path $dotEnv["BACKEND_FOLDER"]
    $imageName = '{0}-backend' -f $dotEnv["APP"]
    docker.exe build -t $imageName -f $dotEnv["BACKEND_DOCKERFILE"] .
    cd -Path $startingDir
}
if ($dotEnv["FRONTEND_FOLDER"] -ne "") {
    cd -Path $dotEnv["FRONTEND_FOLDER"]
    if ($dotEnv["FRONTEND_FRAMEWORK"] = "react") {
        npm run build
    }
    $imageName = '{0}-frontend' -f $dotEnv["APP"]
    docker.exe build -t $imageName -f $dotEnv["FRONTEND_DOCKERFILE"] .
    cd -Path $startingDir
}

docker-compose.exe up
