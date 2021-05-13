@echo off
FOR /F "tokens=3 usebackq delims==." %%i IN (`ver`) DO set BUILDNR=%%i
if %BUILDNR% LSS 21376 (
    echo "Windows build number %BUILDNR% requires local pulseaudio"
    start pulseaudio-1.1\bin\pulseaudio.exe
)
start wsl -d MusicAI