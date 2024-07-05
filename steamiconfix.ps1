# steam icon fix
# benjaminmorozov@gmail.com 05/07/2024

param (
    [string]$dir = "." # current directory
)

# Function to get the target path of a .url file
function Get-UrlTargetPath {
    param (
        [string]$urlFilePath
    )

    # Create a WScript.Shell COM object
    $shell = New-Object -ComObject WScript.Shell

    # Create a shortcut object from the .url file
    $shortcut = $shell.CreateShortcut($urlFilePath)

    # Get the target path from the shortcut
    $targetPath = $shortcut.TargetPath

    # Return the target path
    return $targetPath
}

# Function to get the icon URL from SteamDB
function Get-SteamIconUrl {
    param (
        [string]$appid
    )

    # Return the icon URL
    return "https://steamdb.info/app/$appid/info/#:~:text=all%20asset%20images-,clienticon"
}

# Get all .url files in the specified directory
$files = Get-ChildItem -Path $dir -Filter *.url

foreach ($file in $files) {
    Write-Output $file.FullName

    # Get the target path of the .url file
    $targetPath = Get-UrlTargetPath -urlFilePath $file.FullName

    Write-Output "target: $targetPath"

    # Get the name of the target file, which is the AppID
    $appid = [System.IO.Path]::GetFileNameWithoutExtension($targetPath)
    Write-Output "AppID: $appid"

    # Get the icon URL from SteamDB
    $iconUrl = Get-SteamIconUrl -appid $appid
    Write-Output "Icon URL: $iconUrl"
}
