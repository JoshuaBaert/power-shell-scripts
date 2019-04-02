$logBlock = $args[0]

function log($text) {
    & $logBlock $text
}

$configDir = 'C:\tools\configs'

$returnDir = Get-Location
Set-Location $configDir

git pull
log 'Pulled configs.'

<#
 # Jetbrains
 #>

$jetConDir = "C:\tools\configs\jetbrains"
@(
'DataGrip',
'Rider',
'Pycharm',
'Webstorm'
) | ForEach-Object {
    $versions = @()
    $hasIde = $false

    $folders = Get-ChildItem $env:USERPROFILE -Directory -Filter "*$_*"

    if ($folders.Length -gt 0) {
        $folders | ForEach-Object {
            $versions += $_
        }

        $versions = $versions | Sort-Object -Descending
        $version = $versions[0]

        write $version

        if (Test-Path "$env:USERPROFILE\$version\config\jba_config") {
            Copy-Item "$jetConDir\josh-code-style.xml" "$env:USERPROFILE\$version\config\jba_config\codestyles\josh-code-style.xml"
            Copy-Item "$jetConDir\josh-theme.icls" "$env:USERPROFILE\$version\config\jba_config\colors\josh-theme.icls"
            Copy-Item "$jetConDir\josh-keymap.xml" "$env:USERPROFILE\$version\config\jba_config\win.keymaps\josh-keymap.xml"
        } else {
            Copy-Item "$jetConDir\josh-code-style.xml" "$env:USERPROFILE\$version\config\codestyles\josh-code-style.xml"
            Copy-Item "$jetConDir\josh-theme.icls" "$env:USERPROFILE\$version\config\colors\josh-theme.icls"
            Copy-Item "$jetConDir\josh-keymap.xml" "$env:USERPROFILE\$version\config\keymaps\josh-keymap.xml"
        }
    }
}

<#
 # VS Code
 #>

$vsConDir = "$configDir\vs-code"

Copy-Item "$vsConDir\settings.json" "$env:APPDATA\Code\User\settings.json"
Copy-Item "$vsConDir\keybindings.json" "$env:APPDATA\Code\User\keybindings.json"

<#
 # Vim
 #>

$viConDir = "$configDir\vim"

Copy-Item "$viConDir\_vimrc" "$env:USERPROFILE\_vimrc"
Remove-Item -Recurse "$env:USERPROFILE\vimfiles"
Copy-Item -Recurse -Force "$viConDir\vimfiles" "$env:USERPROFILE"

<#
 # Powershell shortcut
 #>

$psConDir = "$configDir\powershell"

Copy-Item "$psConDir\Windows PowerShell.lnk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk"

log 'Coppied configs.'
cd $returnDir
