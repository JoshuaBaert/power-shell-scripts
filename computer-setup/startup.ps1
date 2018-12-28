$timestamp = Get-Date -Format g
Write-Host @"

Running Startup
$timestamp

"@

$location = Split-Path -Path $PSScriptRoot -Parent
$message = git status

Set-Location  $location

if($message -like '*nothing to commit, working tree clean*') {
    git pull
} else {
    Write-Host 'Currently not clean branch'
}