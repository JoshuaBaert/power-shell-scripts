$scriptsRootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$loginScript = "$scriptsRootDir\on-login\startup.ps1"

$cmdText = @"
PowerShell $loginScript >> "%TEMP%\StartupLog.txt" 2>&1
"@
$filePath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.cmd"

if(Test-Path $filePath) {
    Remove-Item $filePath
}

 New-Item -ItemType "file" -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.cmd" -Value $cmdText
