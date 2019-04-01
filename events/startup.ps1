
. $PSScriptRoot/helpers.ps1 'startup'

Set-Location $location

Start-Transcript -Append -Path "$location\logs\startup.txt"

logOut @"

Running Startup             $timestamp

"@

if (!([Console]::NumberLock)) {
    $wsh = New-Object -ComObject WScript.Shell
    $wsh.SendKeys('{NUMLOCK}')
    logOut 'Turned on numlock.'
}

$message = git status
if ($message -like '*nothing to commit, working tree clean*') {
    logOut (git pull)
} else {
    logOut 'Script repo currently not clean did not pull.'
}

& "$PSScriptRoot\configs.up.ps1" $logBlock

# Starting hotkeys
if (Test-Path 'C:\tools\configs\hotkeys.ahk') { Invoke-Item -Path 'C:\tools\configs\hotkeys.ahk' }
else { logout 'No hotkeys file.' }

if (Test-Path 'C:\tools\configs\local.ahk') { Invoke-Item -Path 'C:\tools\configs\local.ahk' }
else { logout 'No local hotkeys file.' }

logOut @"

"@

Stop-Transcript
