$logBlock = $args[0]

function log($text) {
    & $logBlock $text
}

function copy($from, $to) {
    $toParent = Split-Path -Parent $to -Parent
    if (!(Test-Path $toParent)) { mkdir $toParent }
    Copy-Item -Force $from $to
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
$ides = @(
'CLion'
'DataGrip',
'IntelliJIdea',
'Pycharm',
'Rider',
'Webstorm'
)

$intelliJSaveFolder = "$env:APPDATA\JetBrains";

foreach ($ide in $ides) {
    $versions = @()

    $folders = Get-ChildItem $intelliJSaveFolder -Directory -Filter "*$ide*" | Sort-Object -Descending

    if ($folders.Length -gt 0) {
        $version = $folders[0]

        write $version

        $currentConfigOutput

        if (Test-Path "$intelliJSaveFolder\$version\jba_config") {
            $currentConfigOutput = "$intelliJSaveFolder\$version\jba_config"

            copy "$jetConDir\josh-keymap.xml" "$currentConfigOutput\win.keymaps\josh-keymap.xml"
        } else {
            $currentConfigOutput = "$intelliJSaveFolder\$version"

            copy "$jetConDir\josh-keymap.xml" "$currentConfigOutput\keymaps\josh-keymap.xml"
        }


        copy "$jetConDir\$ide-josh-code-style.xml" "$currentConfigOutput\codestyles\josh-code-style.xml"
        copy "$jetConDir\josh-theme.icls" "$currentConfigOutput\colors\josh-theme.icls"

        copy "$jetConDir\editor.codeinsight.xml" "$currentConfigOutput\editor.codeinsight.xml"
        copy "$jetConDir\editor.xml" "$currentConfigOutput\editor.xml"
        copy "$jetConDir\ide.general.xml" "$currentConfigOutput\ide.general.xml"

        copy "$jetConDir\templates\Angular.xml" "$currentConfigOutput\templates\Angular.xml"
        copy "$jetConDir\templates\JavaScript-Testing.xml" "$currentConfigOutput\templates\JavaScript Testing.xml"
        copy "$jetConDir\templates\JavaScript.xml" "$currentConfigOutput\templates\JavaScript.xml"
    }
}

<#
 # VS Code
 #>

$vsConDir = "$configDir\vs-code"

copy "$vsConDir\settings.json" "$env:APPDATA\Code\User\settings.json"
copy "$vsConDir\keybindings.json" "$env:APPDATA\Code\User\keybindings.json"

<#
 # Terminal
 #>

$termFigsDir = "$configDir\win-terminal"
if (Test-Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState") {
    copy "$termFigsDir\settings.json" "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}

<#
 # Vim
 #>

$viConDir = "$configDir\vim"

copy "$viConDir\_vimrc" "$env:USERPROFILE\_vimrc"
Remove-Item -Recurse "$env:USERPROFILE\vimfiles"
copy -Recurse -Force "$viConDir\vimfiles" "$env:USERPROFILE"

<#
 # Powershell shortcut
 #>

$psConDir = "$configDir\powershell"

copy "$psConDir\Windows PowerShell.lnk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk"

log 'Coppied configs.'
cd $returnDir
