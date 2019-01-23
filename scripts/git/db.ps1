param (
    [switch] $noRemote = $false,
    [switch] $force = $false
)

$branchName = $args[0]

if(!$branchName) {
    $branchName = Read-Host -Prompt 'BranchName'
}

if($branchName -ne '') {
    if(!$noRemote) {
        git push --delete origin $branchName
    }
    if($force) {
        git branch -D $branchName
    } else {
        git branch -d $branchName
    }
}