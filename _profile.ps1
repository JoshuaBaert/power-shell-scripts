# To get this file working you need to have the folowing file :
# C:\WINDOWS\System32\WindowsPowerShell\v1.0\profile.ps1
# then add these lines :
# 
# $scriptsDir C:\path\to\this\dir <--- Important!!
# Import-Module $scriptsDir\_profile.ps1

# Required config Vars
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