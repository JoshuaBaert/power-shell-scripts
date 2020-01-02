# Config Vars
if (Test-Path "$PSScriptRoot\local.ps1") { Import-Module "$PSScriptRoot\local.ps1" }
if (Test-Path "$PSScriptRoot\test.ps1") { New-Alias test "$PSScriptRoot\test.ps1" }

# Import configs
Get-ChildItem "$PSScriptRoot\configs" -Filter *.ps1 | Foreach-Object {
    Import-Module $_.FullName
}

# Remove overwritten aliases
Remove-Item alias:\gmo -Force

Get-ChildItem "$PSScriptRoot\scripts" -Directory | ForEach-Object {
    $prefix = $_.Name.SubString(0,1)

    # Some need special prefixes
    switch ($_.Name) {
        'helpers' { $prefix = '' }
        'chocolatey' { $prefix = 'ch' }
        'setup' { $prefix = 'setup' }
        Default {}
    }

    Get-ChildItem $_.FullName -Filter *.ps1 | Foreach-Object {
        if ($_ -notlike '_profile.ps1') {
            $alias = $_.Name -replace ".ps1",""
            New-Alias -Name "$prefix$alias" $_.FullName
        } 
        if ($_.Name -like '_profile.ps1') {
            Import-Module $_.FullName
        }
    }
}

# Directory Work

$dir = Get-Location

Set-Location $preferedDir

function cdps { Set-Location $scriptsDir }
function cdc { Set-Location $preferedDir }
function cdw { Set-Location "$preferedDir\work" }
function cdp { Set-Location "$preferedDir\personal" }
function cdl { Set-Location "$preferedDir\learning" }

Remove-Variable alias
Remove-Variable prefix
Remove-Variable dir

