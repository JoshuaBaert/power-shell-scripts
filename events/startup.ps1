
. $PSScriptRoot/helpers.ps1 'startup'

Set-Location $location

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
    git pull
    logOut 'Updated script repo.'
} else {
    logOut 'Script repo currently not clean did not pull.'
}

& "$PSScriptRoot\configs.up.ps1" $logBlock

