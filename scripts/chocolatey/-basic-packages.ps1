$packages =
    '7zip',
    'autohotkey',
    'git',
    'greenshot',
    'mountain-duck',
    'nodejs',
    'postman',
    'screentogif',
    'slack',
    'vim',
    'vscode',
    'webstorm'

# Other usefull packages
# fiddler

$list = choco list --local-only

# Write-Host -Separator `n $list

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    forEach ($p in $packages) {
        if ($list -like "*$p*") {
            Write-Host 'skipping' $p
        } else {
            Write-Host 'installing' $p
            choco install --confirm $p
        }
    }
} else {
    Write-Error 'Not in admin, retry in admin'
}

$win10packages = 'wsl-ubuntu-1804'
# TODO Install windows 10 packages??
# (Get-WMIobject Win32_Operatingsystem).version << Gets version number

