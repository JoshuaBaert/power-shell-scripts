
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(!($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))){
    msg * 'Rerun as Admin'
    exit
}

if (!(Get-Module -ListAvailable -Name PsIni)) {
    Install-Module -SkipPublisherCheck -Name PsIni
    write 'installed PsIni'
}

$scriptsRootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

$iniPath = "C:\Windows\System32\GroupPolicy\User\Scripts\psscripts.ini"

$psIni = @"
[ScriptsConfig]
StartExecutePSFirst=false
EndExecutePSFirst=true
[Logon]
0CmdLine=$scriptsRootDir\events\startup.ps1
0Parameters=
[Logoff]
0CmdLine=$scriptsRootDir\events\shutdown.ps1
0Parameters=
"@

if((Test-Path $iniPath)) { Remove-Item $iniPath -Force }

#$psIni | Out-File $iniPath -Encoding unicode -Force
#$iniFile = Get-Item $iniPath -force
#$iniFile.attributes="Hidden"

$scriptsConfig = @{
    StartExecutePSFirst = 'false'
    EndExecutePSFirst =   'true'
}
$logon = @{
    '0CmdLine' =    "$scriptsRootDir\events\startup.ps1"
    '0Parameters' = ''
}
$logoff = @{
    '0CmdLine' =    "$scriptsRootDir\events\shutdown.ps1"
    '0Parameters' = ''
}
$newIniContent = [ordered] @{
    ScriptsConfig = $scriptsConfig
    Logon = $logon
    Logoff = $logoff
}

$newIniContent | Out-IniFile -filePath $iniPath -Encoding unicode -Force
