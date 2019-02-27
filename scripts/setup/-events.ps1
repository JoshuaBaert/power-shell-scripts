# To understand better go here http://www.hexacorn.com/blog/2017/01/07/beyond-good-ol-run-key-part-52/

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if(!($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))){
    msg * 'Rerun as Admin'
    exit
}

$scriptsRootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$startScriptsRoot = 'C:\Windows\System32\GroupPolicy\User\Scripts'

"& $scriptsRootDir\events\startup.ps1" | Out-File "$startScriptsRoot\Logon\startup.ps1"
"& $scriptsRootDir\events\shutdown.ps1" | Out-File "$startScriptsRoot\Logoff\shutdown.ps1"


$iniPath = "$startScriptsRoot\psscripts.ini"
if((Test-Path $iniPath)) { Remove-Item $iniPath -Force }

$psIni = @"
[ScriptsConfig]
StartExecutePSFirst=false
EndExecutePSFirst=true
[Logon]
0CmdLine=startup.ps1
0Parameters=
[Logoff]
0CmdLine=shutdown.ps1
0Parameters=
"@

$psIni | Out-File $iniPath -Encoding unicode -Force
$iniFile = Get-Item $iniPath -force
$iniFile.attributes="Hidden"

$userInfo = whoami /user
$sidRow = $userInfo -match 'S-\d-\d-\d{2}-\d{10}-\d{10}-\d{10}-\d{6}'
$sid = $sidRow -replace '.*(S-\d-\d-\d{2}-\d{10}-\d{10}-\d{10}-\d{6}).*', '$1'
$exeTime = ([Byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00))

$hLogonScriptPathRoot = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Group Policy\Scripts\Logon\0"
$hLogonScriptPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Group Policy\Scripts\Logon\0\0"
$hLogonStatePathRoot = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\$sid\Scripts\Logon\0"
$hLogonStatePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\$sid\Scripts\Logon\0\0"

if(!(Test-Path $hLogonScriptPathRoot)) { New-Item $hLogonScriptPathRoot }
if(!(Test-Path $hLogonStatePathRoot )) { New-Item $hLogonStatePathRoot }

if((Test-Path $hLogonScriptPath)) { Remove-Item $hLogonScriptPath -Force }
if((Test-Path $hLogonStatePath)) { Remove-Item $hLogonStatePath -Force }

New-Item -Path $hLogonScriptPathRoot -Name '0'
New-ItemProperty -Path $hLogonScriptPath -Name "Script" -Value startup.ps1  -PropertyType "String"
New-ItemProperty -Path $hLogonScriptPath -Name "Parameters" -Value $null  -PropertyType "String"
New-ItemProperty -Path $hLogonScriptPath -Name "IsPowershell" -Value 1 -PropertyType "DWord"
New-ItemProperty -Path $hLogonScriptPath -Name ExecTime -Value $exeTime

New-Item -Path $hLogonStatePathRoot -Name '0'
New-ItemProperty -Path $hLogonStatePath -Name "Script" -Value startup.ps1  -PropertyType "String"
New-ItemProperty -Path $hLogonStatePath -Name "Parameters" -Value $null  -PropertyType "String"
New-ItemProperty -Path $hLogonStatePath -Name "IsPowershell" -Value 1 -PropertyType "DWord"
New-ItemProperty -Path $hLogonStatePath -Name ExecTime -Value $exeTime

$hLogoffScriptPathRoot = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Group Policy\Scripts\Logoff\0"
$hLogoffScriptPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Group Policy\Scripts\Logoff\0\0"
$hLogoffStatePathRoot = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\$sid\Scripts\Logoff\0"
$hLogoffStatePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\$sid\Scripts\Logoff\0\0"

if(!(Test-Path $hLogoffScriptPathRoot)) { New-Item $hLogoffScriptPathRoot }
if(!(Test-Path $hLogoffStatePathRoot )) { New-Item $hLogoffStatePathRoot }

if((Test-Path $hLogoffScriptPath)) { Remove-Item $hLogoffScriptPath -Force }
if((Test-Path $hLogoffStatePath)) { Remove-Item $hLogoffStatePath -Force }

New-Item -Path $hLogoffScriptPathRoot -Name '0'
New-ItemProperty -Path $hLogoffScriptPath -Name "Script" -Value shutdown.ps1  -PropertyType "String"
New-ItemProperty -Path $hLogoffScriptPath -Name "Parameters" -Value $null  -PropertyType "String"
New-ItemProperty -Path $hLogoffScriptPath -Name "IsPowershell" -Value 1 -PropertyType "DWord"
New-ItemProperty -Path $hLogoffScriptPath -Name ExecTime -Value $exeTime

New-Item -Path $hLogoffStatePathRoot -Name '0'
New-ItemProperty -Path $hLogoffStatePath -Name "Script" -Value shutdown.ps1  -PropertyType "String"
New-ItemProperty -Path $hLogoffStatePath -Name "Parameters" -Value $null  -PropertyType "String"
New-ItemProperty -Path $hLogoffStatePath -Name "IsPowershell" -Value 1 -PropertyType "DWord"
New-ItemProperty -Path $hLogoffStatePath -Name ExecTime -Value $exeTime
