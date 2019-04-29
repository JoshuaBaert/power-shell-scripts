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

        $currentConfigOutput

        if (Test-Path "$env:USERPROFILE\$version\config\jba_config") {
            $currentConfigOutput = "$env:USERPROFILE\$version\config\jba_config"

            if (!(Test-Path "$currentConfigOutput\win.keymaps\")) {
                mkdir "$currentConfigOutput\win.keymaps\"
            }
            Copy-Item -Force "$jetConDir\josh-keymap.xml" "$currentConfigOutput\win.keymaps\josh-keymap.xml"
        } else {
            $currentConfigOutput = "$env:USERPROFILE\$version\config"

            if (!(Test-Path "$currentConfigOutput\keymaps\")) {
                mkdir "$currentConfigOutput\keymaps\"
            }
            Copy-Item -Force "$jetConDir\josh-keymap.xml" "$currentConfigOutput\keymaps\josh-keymap.xml"
        }

        write "$jetConDir\josh-theme.icls"
        write "$currentConfigOutput\colors\josh-theme.icls"

        if (!(Test-Path "$currentConfigOutput\codestyles")) {
            mkdir "$currentConfigOutput\codestyles\"
        }
        Copy-Item -Force "$jetConDir\josh-code-style.xml" "$currentConfigOutput\codestyles\josh-code-style.xml"

        if (!(Test-Path "$currentConfigOutput\colors")) {
            mkdir "$currentConfigOutput\colors\"
        }
        Copy-Item -Force "$jetConDir\josh-theme.icls" "$currentConfigOutput\colors\josh-theme.icls"

        Copy-Item "$jetConDir\editor.codeinsight.xml" "$currentConfigOutput\editor.codeinsight.xml"
        Copy-Item "$jetConDir\editor.xml" "$currentConfigOutput\editor.xml"
        Copy-Item "$jetConDir\ide.general.xml" "$currentConfigOutput\ide.general.xml"
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
