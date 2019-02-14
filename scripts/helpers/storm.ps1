
$appDir = "$env:USERPROFILE\AppData\Local\JetBrains\Toolbox\apps\WebStorm\ch-0"
$versions = @()

Get-ChildItem $appDir -Directory | ForEach-Object {
    $versions += $_.Name
}

$versions = $versions | Sort-Object -Descending
$version = $versions[0]

if ($args) {
    Start-Process "$appdir\$version\bin\webstorm64.exe" $args
} else {
    $currenLocation = Get-Location
    Start-Process "$appdir\$version\bin\webstorm64.exe" $currenLocation
}
