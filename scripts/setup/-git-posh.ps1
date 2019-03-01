# Setup
$startingDir = pwd
$repoUrl = 'https://github.com/dahlbyk/posh-git.git'


function profile {

}

# Execution

if (!(Test-Path 'C:\tools')) {
    mkdir C:\tools
}

Set-Location C:\tools

if (!(Test-Path 'C:\tools\posh-git')) {
    # install post-git
    git clone $repoUrl

} else {Write-Warning "Posh Git already exists" }



Set-Location $startingDir
