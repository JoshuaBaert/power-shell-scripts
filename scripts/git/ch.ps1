param (
    [switch] $pull = $false
)

$branchName = $args[0]
$branches = git branch

function checkout {
    git checkout $args
    if ($branchName -like "*master*" -or $branchName -like "*dev*"){
        git pull
    } elseif ($pull) {
        git pull
    }
}

if ($branches -like "*$branchName*") {
    checkout $args
} else {
    $remoteBranches = git ls-remote --heads
    $matchingBranches = $remoteBranches -match ".*$branchName.*"

    if (($matchingBranches.length) -gt 0) {
        write 'Checking out remote branch.'
        git fetch
        checkout $args
    } else {
        write 'Creating new branch'
        checkout -b $args
    }
}

