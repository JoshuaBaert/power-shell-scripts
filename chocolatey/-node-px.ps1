
function install { choco install -y nodejs --version 8.11.4 }

$list = choco list --local-only
if($present -like 'nodejs' -and $list -notlike '8.11.4') { 
    choco uninstall -y nodejs
    install
} elseif ($present -notlike 'nodejs') {
    install
}