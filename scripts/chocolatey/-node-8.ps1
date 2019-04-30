
function install { choco install -y nodejs --version 8.15.1 }
function installNew { choco install -y nodejs }

$list = choco list --local-only
if ($list -like '*nodejs*8.15.1*') {
    choco uninstall -y nodejs
    installNew
} elseif ($list -like '*nodejs*') {
    choco uninstall -y nodejs
    install
} elseif ($list -notlike '*nodejs*') {
    install
}
