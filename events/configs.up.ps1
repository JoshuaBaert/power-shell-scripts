$logBlock = $args[0]

function log($text) {
    & $logBlock $text
}

$configDir = 'C:\tools\configs'

$returnDir = Get-Location
Set-Location $configDir

git pull
log 'Pulled from git.'

<#
 # Jetbrains
 #>

$jetConDir = "$configDir\jetbrains"
$versions = @()

Get-ChildItem $env:USERPROFILE -Directory -Filter '*Webstorm*' | ForEach-Object {
    $versions += $_
}

$versions = $versions | Sort-Object -Descending
$version = $versions[0]

Copy-Item "$jetConDir\josh-code-style.xml" "$env:USERPROFILE\$version\config\jba_config\codestyles\josh-code-style.xml"
Copy-Item "$jetConDir\josh-theme.icls" "$env:USERPROFILE\$version\config\jba_config\colors\josh-theme.icls"
Copy-Item "$jetConDir\josh-keymap.xml" "$env:USERPROFILE\$version\config\jba_config\win.keymaps\josh-keymap.xml"

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

log 'Coppied configs.'
cd $returnDir
