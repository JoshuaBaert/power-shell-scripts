$branchName = $args[0]
$branches = git branch

if($branches -like "*$branchName*") {
    git checkout $args
} else {
    git fetch
    git checkout $args
}
