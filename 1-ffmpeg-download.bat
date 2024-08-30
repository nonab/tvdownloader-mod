@echo off

setlocal enabledelayedexpansion

:: Set repository information
set repo=BtbN/FFmpeg-Builds

:: Download the latest release containing ffmpeg-master-latest-win64-gpl.zip
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/%repo%/releases/latest ^| find "browser_download_url" ^| find "ffmpeg-master-latest-win64-gpl.zip"') do (
     call :download "%%B"
)

:: Extract ffmpeg.exe from the ZIP file
call :extract

:: Clean up by deleting the ZIP file
call :cleanup

goto :eof

:download
set "url=%~1"
echo Downloading %url%
curl -kOL %url%
goto :eof

:extract
echo Extracting ffmpeg.exe from ffmpeg-master-latest-win64-gpl.zip
:: Using PowerShell to extract only the ffmpeg.exe file
powershell -command "Expand-Archive -Path 'ffmpeg-master-latest-win64-gpl.zip' -DestinationPath '.' -Force; Move-Item -Path '.\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe' -Destination '.'"
goto :eof

:cleanup
echo Cleaning up...
:: Delete the ZIP file and the extracted folder
del ffmpeg-master-latest-win64-gpl.zip
rd /s /q ffmpeg-master-latest-win64-gpl
goto :eof
