@echo off
:: steam icon fix
:: benjaminmorozov@gmail.com 04/07/2024
setlocal enabledelayedexpansion
:: delayed expansion to get the updated value of the variable within the loop

:: set the directory from command-line argument or current directory if not set
set "dir=%~1"
if "%dir%"=="" set "dir=."

:: iterate over .url files in the specified directory
for %%f in ("%dir%\*.url") do (
    echo Processing: %%f

    :: extract the target path from the .url file using ps
    for /f "tokens=*" %%i in ('powershell -NoProfile -Command "$shell = New-Object -ComObject WScript.Shell; $shortcut = $shell.CreateShortcut('%%~f'); $shortcut.TargetPath"') do set "targetPath=%%i"
    echo Target path: !targetPath!

    :: extract the appid (filename without extension) from the target path
    for %%F in ("!targetPath!") do set "appid=%%~nxF"
    echo AppID: !appid!

    :: construct the URL for the SteamDB page
    echo "https://steamdb.info/app/!appid!/info/#:~:text=all%%20asset%%20images-,clienticon"
)
endlocal
