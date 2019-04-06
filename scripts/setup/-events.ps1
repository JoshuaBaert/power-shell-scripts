
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))){
    msg * 'Rerun as Admin'
    exit
}

$scriptsRootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$startScriptsRoot = 'C:\Windows\System32\GroupPolicy\User\Scripts'

"& $scriptsRootDir\events\startup.ps1" | Out-File "$startScriptsRoot\Logon\startup.ps1"
"& $scriptsRootDir\events\shutdown.ps1" | Out-File "$startScriptsRoot\Logoff\shutdown.ps1"
