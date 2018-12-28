$timestamp = Get-Date -Format g

Write-Host @"

Running Startup
$timestamp

"@


$location = Split-Path -Path $PSScriptRoot -Parent
Set-Location  $location

$message = git status

if($message -like '*nothing to commit, working tree clean*') {
    git pull
} else {
    Write-Host 'Currently not clean branch'
}