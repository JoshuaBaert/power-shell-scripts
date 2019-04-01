
. $PSScriptRoot\helpers.ps1 'shutdown'

Start-Transcript -Append -Path "$location\logs\shutdown.txt"

Set-Location $location

logOut @"

Running Shutdown            $timestamp

"@

& "$PSScriptRoot\configs.down.ps1" $logBlock


logOut @"

"@

Stop-Transcript
