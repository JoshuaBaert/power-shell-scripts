$cmdText = @"
PowerShell $PSScriptRoot\startup.ps1 >> "%TEMP%\StartupLog.txt" 2>&1
"@
$filePath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.cmd"

if(Test-Path $filePath) {
    Remove-Item $filePath
}

New-Item -ItemType "file" -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.cmd" -Value $cmdText