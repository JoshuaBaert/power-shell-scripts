$message = git status

if($message -like '*nothing to commit, working tree clean*') {    
    git checkout master
    git pull
    git checkout -
    git merge master

    $status = git status
    if($status -like '*Your branch is ahead of*' -And $status -like '*Your branch is ahead of*') {
        Write-Host 'Pushing the merge up'
        git push
    }
} else {
    Write-Warning 'Not working on a clean branch or not in a git directory'
}

$message = $null
$status = $null