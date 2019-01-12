
function install { choco install -y nodejs --version 8.11.4 }
function installNew { choco install -y nodejs }

$list = choco list --local-only
if($list -like '*nodejs*8.11.4*') {
    choco uninstall -y nodejs
    installNew
} elseif ($list -like '*nodejs*') {
    choco uninstall -y nodejs
    install
} elseif ($list -notlike '*nodejs*') {
    install
}