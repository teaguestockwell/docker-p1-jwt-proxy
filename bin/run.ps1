docker-compose.exe down
$templateNginx = ".\src\nginx.conf"
$genNginx = ".\src\nginx.generated.conf"
Copy-Item $templateNginx $genNginx -Force
# Parse the .env file into a hashtable
$dotEnv = @{ }
Get-Content ".\.env" | Where-Object { $_.length -gt 0 } | Where-Object { !$_.StartsWith("#") } | ForEach-Object {
    $var = $_.Split('=', 2).Trim()
    [void]$dotEnv.Add($var[0], $var[1])
}
# Iterate through the hashtable and replace '${env}' with equivalent value inside of the nginx conf
# Looping a Get-Content (cat in *nix) along with Set-Content is messy, but its fine for small files
foreach ($key in $dotEnv.Keys) {
    $val = $dotEnv[$key]
    if ($val -ne "") {
        ((Get-Content -path $genNginx -Raw) -replace "\`${$key}", $val) | Set-Content -Path $genNginx
    }
}
docker-compose.exe up