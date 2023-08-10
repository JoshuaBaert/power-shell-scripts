
function touch($fileName) {
    New-Item -ItemType file $fileName
}

function rmrf {
    rm -Recurse -Force $args
}

function isAdmin {
    write (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function live {
    npx live-server --no-browser
}

function coverage {
    cd ./coverage
    try {
        live
    } finally {
        cd ../
    }
}
