# Vars
$test = 'Yep.. Working!'
$preferedDir = 'C:\git\work'

# Check
$dir = pwd
switch -Regex ($dir) {
    '^C\:\\' { set-location $preferedDir }
    '^H\:\\' { set-location $preferedDir }
    Default {}
}

$prefix = 'g'
Get-ChildItem 'C:\Users\uc249159\ps-scripts\git' -Filter *.ps1 | 
Foreach-Object {
    if ($_ -notlike '_profile.ps1') {
        $alias = $_ -replace ".ps1",""
        New-Alias "$prefix$alias" $_.FullName
    }
}
