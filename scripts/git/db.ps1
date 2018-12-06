$branchName = $args[0]

if(!$branchName) {
    $branchName = Read-Host -Prompt 'BranchName'
}

if($branchName -ne '') {
    git push --delete origin $branchName
    git branch -d $branchName
}