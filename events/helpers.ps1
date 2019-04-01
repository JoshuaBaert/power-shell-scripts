$logName = $args[0]
$timestamp = Get-Date -Format g
$location = Split-Path -Path $PSScriptRoot -Parent

if (!(Test-Path "$location\logs")) { md "$location\logs" }

function logOut () {
    write $args
}

$logBlock = {
    write $args
}
