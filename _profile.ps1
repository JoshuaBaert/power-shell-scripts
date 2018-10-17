# Config Vars
import-Module $scriptsDir\config.ps1

# Import Extra Modules 
if (Get-Module -ListAvailable -Name PSReadLine) { Import-Module $scriptsDir\colorsEtc.ps1 }

# Vars
$test = 'Yep.. Working!'

# Check working director and maybe redirect
$dir = Get-Location

if ($excludedDirs -contains $dir){
    Set-Location $preferedDir
}

$prefix = 'g'
Get-ChildItem "$scriptsDir\git" -Filter *.ps1 | Foreach-Object {
    if ($_ -notlike '_profile.ps1') {
        $alias = $_ -replace ".ps1",""
        New-Alias "$prefix$alias" $_.FullName
    }
}

$prefix = $null