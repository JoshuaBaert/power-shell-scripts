param (
    [switch] $pull = $false
)

$branchName = $args[0]
$branches = git branch

function checkout {
    git checkout $args
    if($pull) { git pull }
}

if($branches -like "*$branchName*") {
    checkout $args
} else {
    git fetch
    checkout $args
}
