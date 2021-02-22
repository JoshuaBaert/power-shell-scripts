$logBlock = $args[0]

function log($text) {
    & $logBlock $text
}

log 'Starting configs.'

$configDir = 'C:\tools\configs'

<#
 # Jetbrains
 #>

$jetFigsDir = "$configDir\jetbrains"

$intelliJSaveFolder = "$env:APPDATA\JetBrains";

$versions = Get-ChildItem $intelliJSaveFolder -Directory -Filter '*Webstorm*' | Sort-Object -Descending
$version = $versions[0]

Copy-Item "$intelliJSaveFolder\$version\colors\josh-theme.icls" "$jetFigsDir\josh-theme.icls"
if (Test-Path "$intelliJSaveFolder\$version\win.keymaps\") { 
    Copy-Item "$intelliJSaveFolder\$version\win.keymaps\josh-keymap.xml" "$jetFigsDir\josh-keymap.xml"
} else {
    Copy-Item "$intelliJSaveFolder\$version\keymaps\josh-keymap.xml" "$jetFigsDir\josh-keymap.xml"
}

Copy-Item "$intelliJSaveFolder\$version\editor.codeinsight.xml" "$jetFigsDir\editor.codeinsight.xml"
Copy-Item "$intelliJSaveFolder\$version\editor.xml" "$jetFigsDir\editor.xml"
Copy-Item "$intelliJSaveFolder\$version\ide.general.xml" "$jetFigsDir\ide.general.xml"

Copy-Item "$intelliJSaveFolder\$version\templates\Angular.xml" "$jetFigsDir\templates\Angular.xml"
Copy-Item "$intelliJSaveFolder\$version\templates\JavaScript Testing.xml" "$jetFigsDir\templates\JavaScript-Testing.xml"
Copy-Item "$intelliJSaveFolder\$version\templates\JavaScript.xml" "$jetFigsDir\templates\JavaScript.xml"

$ides = @(
'DataGrip',
'Rider',
'Pycharm',
'Webstorm'
)
foreach ($ide in $ides) {
    $ideVersions = Get-ChildItem $intelliJSaveFolder -Directory -Filter "*$ide*" | Sort-Object -Descending
    if ($ideVersions.Length -gt 0) {
        $ideVersion = $ideVersions[0]

        write $ideVersion

        $currentConfigOutput
        if (Test-Path "$intelliJSaveFolder\$ideVersion\jba_config") {
            $currentConfigOutput = "$intelliJSaveFolder\$ideVersion\jba_config"
        } else {
            $currentConfigOutput = "$intelliJSaveFolder\$ideVersion"
        }

        Copy-Item "$currentConfigOutput\codestyles\josh-code-style.xml" "$jetFigsDir\$ide-josh-code-style.xml"
    }
}

<#
 # VS Code
 #>

$vsFigsDir = "$configDir\vs-code"

Copy-Item "$env:APPDATA\Code\User\settings.json" "$vsFigsDir\settings.json"
Copy-Item "$env:APPDATA\Code\User\keybindings.json" "$vsFigsDir\keybindings.json"

<#
 # Terminal
 #>

$termFigsDir = "$configDir\win-terminal"

Copy-Item "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "$termFigsDir\settings.json"

<#
 # Vim
 #>

$viConDir = "$configDir\vim"

Copy-Item "$env:USERPROFILE\_vimrc" "$viConDir\_vimrc"
Remove-Item -Recurse "$viConDir\vimfiles"
Copy-Item -Recurse -Force "$env:USERPROFILE\vimfiles" "$viConDir\"

<#
 # Save
 #>

$returnDir = Get-Location
Set-Location $configDir

$message = git status
if (!($message -like '*nothing to commit, working tree clean*')) {
    $timestamp = Get-Date -Format g

    git add .
    git commit -m "configs changed $timestamp"
    git push
    log 'Updated configs.'
} else {
    log 'No configs to update.'
}

Set-Location $returnDir

