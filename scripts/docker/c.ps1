<#
 # This file is to shortcut docker-compose and add a few goodies I like
 #>

param (
    [switch] $v = $false
)

[System.Collections.ArrayList]$ments = '', ''
foreach ($arg in $args) { $ments.Add($arg) }
while ($ments -contains '') { $ments.Remove('') }

if ($ments[0] -eq 'up') {
    $ments.Remove('up')
    if ($v) {
        docker-compose up $ments
    } else {
        docker-compose up -d $ments
    }
}

if ($ments[0] -eq 'down') {
    $ments.Remove('down')
    docker-compose down --volumes --remove-orphans $ments
}
