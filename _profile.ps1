# Config Vars
if (Test-Path "$scriptsDir\local.ps1") { Import-Module "$scriptsDir\local.ps1" }
if (Test-Path "$scriptsDir\test.ps1") { New-Alias test "$scriptsDir\test.ps1" }

# Import configs
Get-ChildItem "$scriptsDir\configs" -Filter *.ps1 | Foreach-Object {
    Import-Module $_.FullName
}

Get-ChildItem "$scriptsDir\scripts" -Directory | ForEach-Object {
    $prefix = $_.Name -replace "(\w).*", '$1'

    switch ($_.Name) {
        'helpers' { $prefix = '' }
        'chocolatey' { $prefix = 'ch' }
        'setup' { $prefix = 'setup' }
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

# Directory Work

$dir = Get-Location

if ($excludedDirs -contains $dir){
    Set-Location $preferedDir
}

function cdps { Set-Location $scriptsDir }
function cdc { Set-Location $preferedDir }
