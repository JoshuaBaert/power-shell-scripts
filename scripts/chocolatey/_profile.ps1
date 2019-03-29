
function chls { choco list --local-only }

function chin { 
    choco install -y $args
}

function chun {
    choco uninstall -y $args
}

