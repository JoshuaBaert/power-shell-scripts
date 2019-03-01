
Import-Module "$PSScriptRoot\helpers.ps1" -ArgumentList 'startup' -Scope Local

$timestamp = Get-Date -Format g
$location = Split-Path -Path $PSScriptRoot -Parent

if (!(Test-Path "$location\logs")) { md "$location\logs" }

function logOut () {
    $args | Out-File -Append "$location\logs\startup-log.txt"
}

Set-Location $location

logOut @"

Running Startup
$timestamp

"@

$message = git status
if ($message -like '*nothing to commit, working tree clean*') {
    git pull
    logOut 'pulled'
} else {
    logOut 'Currently not clean branch'
}
