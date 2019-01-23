param (
    [switch] $noRemote = $false
)

$branchName = $args[0]

if(!$branchName) {
    $branchName = Read-Host -Prompt 'BranchName'
}

if($branchName -ne '') {
    if(!$noRemote) {
        git push --delete origin $branchName
    }
    git branch -D $branchName
}