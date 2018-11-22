# Config Vars
Import-Module $scriptsDir\local.ps1

# Import Extra Modules 
if (Get-Module -ListAvailable -Name PSReadLine) { Import-Module $scriptsDir\configs\colorsEtc.ps1 }
if (Test-Path 'C:\tools\posh-git\src\posh-git.psm1') {
    Import-Module C:\tools\posh-git\src\posh-git.psm1
    Import-Module $scriptsDir\configs\posh-git.ps1 

    # This can be used to change the prompt
    function prompt { return & $GitPromptScriptBlock }
}

# Vars
$test = 'Yep.. Working!'

# Check working director and maybe redirect
$dir = Get-Location

if ($excludedDirs -contains $dir){
    Set-Location $preferedDir
}

Get-ChildItem "$scriptsDir\scripts" -Directory | ForEach-Object {
    $prefix = $_.Name -replace "(\w).*", '$1'

    if($_.Name -eq 'chocolatey'){ $prefix = 'ch' }

    Get-ChildItem $_.FullName -Filter *.ps1 | Foreach-Object {
        if ($_ -notlike '_profile.ps1') {
            $alias = $_ -replace ".ps1",""
            New-Alias "$prefix$alias" $_.FullName
        } elseif($_ -like '_profile.ps1') {
            Import-Module $_.FullName
        }
    }
}

Remove-Variable alias
Remove-Variable prefix

function cdps { Set-Location $scriptsDir }
function cdc { Set-Location $preferedDir }

# Playing with C#
# $testSource = Get-Content -Path "$scriptsDir\console\test.cs"
# Add-Type -TypeDefinition "$testSource"
# $basicTest = New-Object BasicTest