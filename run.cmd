rem docker-compose down
for /F "tokens=*" %%A in (.env) do set %%A
set INTEXTFILE=src/nginx.conf
set OUTTEXTFILE=src/nginx.generated.conf
set SEARCHTEXT=${APP}
set REPLACETEXT=%APP%
set OUTPUTLINE=

for /f "tokens=1,* delims=¶" %%A in ( '"findstr /n ^^ %INTEXTFILE%"') do (
   SET string=%%A
   for /f "delims=: tokens=1,*" %%a in ("!string!") do set "string=%%b"
   if  "!string!" == "" (
       echo.>>%OUTTEXTFILE%
   ) else (
      SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!
      echo !modified! >> %OUTTEXTFILE%
  )
)

rem docker-compose up