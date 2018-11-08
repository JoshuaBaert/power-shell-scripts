$packages = 
    'git',
    'slack',
    'nodejs',
    'cyberduck',
    'greenshot',
    'jetbrainstoolbox'

$list = choco list --local-only

# Write-Host -Separator `n $list

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    forEach ($p in $packages) {
        if($list -like "*$p*") {
            Write-Host 'not installing' $p
        }else {
            Write-Host 'installing' $p
            choco install --confirm $p
        }
    }
} else {
    Write-Error 'Not in admin, retry in admin'
}
