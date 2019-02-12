# Config Vars
Import-Module $scriptsDir\local.ps1

# Helpers 
Import-Module $scriptsDir\helpers.ps1

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

# Setup Aliases

New-Alias "cs-install" "$scriptsDir\computer-setup\install.ps1"
New-Alias "cs-startup" "$scriptsDir\computer-setup\startup.ps1"
New-Alias 'ps-exe' "$scriptsDir\ps2exe.ps1"

Get-ChildItem "$scriptsDir\scripts" -Directory | ForEach-Object {
    $prefix = $_.Name -replace "(\w).*", '$1'

    switch ($_.Name) {
        'chocolatey' { $prefix = 'ch' }
        'computer-setup' { $prefix = 'cs' }
        Default {}
    }

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