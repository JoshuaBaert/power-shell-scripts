if($host.version.major -eq 5) {
    $IsWindows = $true
}

echo $IsWindows

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

if ($excludedDirs -contains $dir){
    Set-Location $preferredDir
}

function cdps { Set-Location $scriptsDir }
function cdc { Set-Location $preferredDir }
function cdw { Set-Location "$preferredDir\work" }
function cdp { Set-Location "$preferredDir\personal" }
function cdl { Set-Location "$preferredDir\learning" }

Remove-Variable alias
Remove-Variable prefix
Remove-Variable dir

