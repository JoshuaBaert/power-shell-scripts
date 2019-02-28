param (
    [switch] $pull = $false
)

$branchName = $args[0]
$branches = git branch

function checkout {
    git checkout $args
    if($branchName -like "*master*" -or $branchName -like "*dev*"){
        git pull
    } else {
        if($pull) { git pull }
    }
}

if($branches -like "*$branchName*") {
    checkout $args
} else {
    git fetch
    checkout $args
}

