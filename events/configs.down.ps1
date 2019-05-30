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

$versions = Get-ChildItem $env:USERPROFILE -Directory -Filter '*Webstorm*' | Sort-Object -Descending
$version = $versions[0]

Copy-Item "$env:USERPROFILE\$version\config\jba_config\colors\josh-theme.icls" "$jetFigsDir\josh-theme.icls"
Copy-Item "$env:USERPROFILE\$version\config\jba_config\win.keymaps\josh-keymap.xml" "$jetFigsDir\josh-keymap.xml"

Copy-Item "$env:USERPROFILE\$version\config\jba_config\editor.codeinsight.xml" "$jetFigsDir\editor.codeinsight.xml"
Copy-Item "$env:USERPROFILE\$version\config\jba_config\editor.xml" "$jetFigsDir\editor.xml"
Copy-Item "$env:USERPROFILE\$version\config\jba_config\ide.general.xml" "$jetFigsDir\ide.general.xml"

$ides = @(
'DataGrip',
'Rider',
'Pycharm',
'Webstorm'
)
foreach ($ide in $ides) {
    $ideVersions = Get-ChildItem $env:USERPROFILE -Directory -Filter "*$ide*" | Sort-Object -Descending
    if ($ideVersions.Length -gt 0) {
        $ideVersion = $ideVersions[0]

        write $ideVersion

        $currentConfigOutput
        if (Test-Path "$env:USERPROFILE\$ideVersion\config\jba_config") {
            $currentConfigOutput = "$env:USERPROFILE\$ideVersion\config\jba_config"
        } else {
            $currentConfigOutput = "$env:USERPROFILE\$ideVersion\config"
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

