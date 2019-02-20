
#Import-Module "$PSScriptRoot\helpers.ps1"

$timestamp = Get-Date -Format g
$location = Split-Path -Path $PSScriptRoot -Parent

if (!(Test-Path "$location\logs")) { md "$location\logs" }

function logOut () {
    $args | Out-File -Append "$location\logs\shutdown-log.txt"
}

Set-Location $location

logOut @"

Running Shutdown
$timestamp

"@


