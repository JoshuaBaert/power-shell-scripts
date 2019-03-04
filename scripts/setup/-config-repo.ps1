
$returnDir = Get-Location

if (!(Test-Path 'C:\tools')) { mkdir 'C:\tools' }
Set-Location 'C:\tools'
git clone 'git@github.com:JoshuaBaert/configs.git'

Set-Location $returnDir
