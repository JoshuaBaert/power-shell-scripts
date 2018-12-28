$timestamp = Get-Date -Format g
$location = Split-Path -Path $PSScriptRoot -Parent
$message = git status

Write-Host @"

Running Startup
$timestamp

"@
Write-Host $location
Write-Host $PSScriptRoot

Set-Location  $location
$currentLocation = Get-Location

Write-Host $currentLocation

if($message -like '*nothing to commit, working tree clean*') {
    git pull
} else {
    Write-Host 'Currently not clean branch'
    Write-Host $message
}