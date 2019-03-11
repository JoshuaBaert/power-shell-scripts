
. $PSScriptRoot\helpers.ps1 'shutdown'

Set-Location $location

logOut @"


Running Shutdown        $timestamp
"@

& "$PSScriptRoot\configs.down.ps1" $logBlock
