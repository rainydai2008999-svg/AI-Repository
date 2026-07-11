@echo off
setlocal
cd /d D:\AI\BrowserUse
"D:\AI\BrowserUse\.venv\Scripts\python.exe" "D:\AI\BrowserUse\launcher\launch_aigbd.py"
if errorlevel 1 pause
endlocal
