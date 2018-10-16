$scriptsDir = 'C:\Users\Joshua\scripts'

# To get this file working you need to have the folowing file :
# C:\WINDOWS\System32\WindowsPowerShell\v1.0\profile.ps1
# then add this line :
# Import-Module C:\path\to\_profile.ps1

# Required config Vars
# $excludedDirs
# $preferedDir
import-Module $scriptsDir\config.ps1

# Import Extra Modules 
Import-Module $scriptsDir\colorsEtc.ps1

# Vars
$test = 'Yep.. Working!'

# Check working director and maybe redirect
$dir = Get-Location

if ($excludedDirs -contains $dir){
    Set-Location $preferedDir
}

# switch -Regex ($dir) {
#     '^C\:\\$' { set-location $preferedDir }
#     '^H\:\\$' { set-location $preferedDir }
#     Default {}
# }

$prefix = 'g'
Get-ChildItem "$scriptsDir\git" -Filter *.ps1 | 
Foreach-Object {
    if ($_ -notlike '_profile.ps1') {
        $alias = $_ -replace ".ps1",""
        New-Alias "$prefix$alias" $_.FullName
    }
}
