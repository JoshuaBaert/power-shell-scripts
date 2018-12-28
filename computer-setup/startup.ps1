$timestamp = Get-Date -Format g
$location = Split-Path -Path $PSScriptRoot -Parent
$message = git status

Write-Host @"

Running Startup
$timestamp

"@

Set-Location  $location

if($message -like '*nothing to commit, working tree clean*') {
    git pull
} else {
    Write-Host 'Currently not clean branch'
}