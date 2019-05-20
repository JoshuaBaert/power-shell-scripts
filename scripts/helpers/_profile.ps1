
function touch($fileName) {
    New-Item -ItemType file $fileName
}

function rmrf {
    rm -Recurse -Force $args
}
