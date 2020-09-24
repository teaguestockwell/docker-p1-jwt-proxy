@echo off
setlocal enabledelayedexpansion
docker-compose down
for /F "tokens=*" %%A in (.env) do (
    set %%A
)
set INTEXTFILE=nginx.conf
set OUTTEXTFILE=nginx.generated.conf
set APPSTARTTEXT=${APP}
set APPENDTEXT=%APP%
set FRONTEND_PORTSTARTTEXT=${FRONTEND_PORT}
set FRONTEND_PORTENDTEXT=%FRONTEND_PORT%
set BACKEND_PORTSTARTTEXT=${BACKEND_PORT}
set BACKEND_PORTENDTEXT=%BACKEND_PORT%
set OUTPUTLINE=
cd src
del %OUTTEXTFILE%
for /f "tokens=1,* delims=¶" %%A in ( '"findstr /n ^^ %INTEXTFILE%"') do (
   SET string=%%A
   for /f "delims=: tokens=1,*" %%a in ("!string!") do set "string=%%b"
   if  "!string!" == "" (
       echo.>>%OUTTEXTFILE%
   ) else (
      SET modified=!string:%APPSTARTTEXT%=%APPENDTEXT%!
      SET modified=!modified:%FRONTEND_PORTSTARTTEXT%=%FRONTEND_PORTENDTEXT%!
      SET modified=!modified:%BACKEND_PORTSTARTTEXT%=%BACKEND_PORTENDTEXT%!
      echo !modified! >> %OUTTEXTFILE%
  )
)
cd ..
docker-compose up