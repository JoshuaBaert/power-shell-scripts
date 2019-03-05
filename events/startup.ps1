
. $PSScriptRoot/helpers.ps1 'startup'

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

