param (
    [switch] $noPush = $false,
    [switch] $noInstall = $false
)

$branchName = $args[0]
if ($branchName -eq $null) {
    Write-Warning 'No branchName'
    exit
}

$message = git status
if ($message -like '*nothing to commit, working tree clean*') {
} else {
    Write-Warning 'Not working on a clean branch or not in a git directory'
    exit
}

$mergeMessage = git merge origin/$branchName
Write-Host $mergeMessage
$status = git status

if ($status -like '*Your branch is ahead of*' -And $status -like '*Your branch is ahead of*') {
    if (!$noPush) {
        Write-Host 'Pushing the merge up'
        git push
    }

    if ($mergeMessage -imatch 'package\.json\s*\|\s*\d*' -and !$noInstall ){
        Write-Host 'Installing new packages'
        npm install
    }
}
