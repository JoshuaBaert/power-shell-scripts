
$timestamp = Get-Date -Format g
$location = Split-Path -Path $PSScriptRoot -Parent

if (!(Test-Path "$location\logs")) { md "$location\logs" }

write $location

function logOut () {
    $args | Out-File -Append "$location\logs\shutdown-log.txt"
}