 @echo off

 setlocal enabledelayedexpansion
 set repo=yt-dlp/yt-dlp
 for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/%repo%/releases/latest ^| find "browser_download_url" ^| find "yt-dlp.exe"') do (
      call :download "%%B"
 )
 goto :eof

 :download
 set "url=%~1"
 echo %url%
 curl -kOL %url%
goto :eof