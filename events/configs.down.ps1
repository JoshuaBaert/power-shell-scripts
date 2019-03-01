$logBlock = $args[0]

function log($text) {
    & $logBlock $text
}

$configDir = 'C:\tools\config'

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

Copy-Item "$env:USERPROFILE\$version\config\jba_config\codestyles\josh-code-style.xml" "$jetConDir\josh-code-style.xml"
Copy-Item "$env:USERPROFILE\$version\config\jba_config\colors\josh-theme.icls" "$jetConDir\josh-theme.icls"
Copy-Item "$env:USERPROFILE\$version\config\jba_config\win.keymaps\josh-keymap.xml" "$jetConDir\josh-keymap.xml"

<#
 # VS Code
 #>

$vsConDir = "$configDir\vs-code"

Copy-Item "$env:APPDATA\Code\User\settings.json" "$vsConDir\settings.json"
Copy-Item "$env:APPDATA\Code\User\keybindings.json" "$vsConDir\keybindings.json"

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
    log 'updated configs'
} else {
    log 'no configs to update'
}

Set-Location $returnDir
