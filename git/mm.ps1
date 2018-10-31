$message = git status

if($message -like '*nothing to commit, working tree clean*') {    
    git checkout master
    $pullMessage = git pull
    git checkout -
    git merge master

    $status = git status
    if($status -like '*Your branch is ahead of*' -And $status -like '*Your branch is ahead of*') {
        Write-Host 'Pushing the merge up'
        git push
    }

    if($pullMessage -imatch 'package\.json\s*\|\s*\d*' ){
        Write-Host 'Installing new packages'
        npm install
    }
} else {
    Write-Warning 'Not working on a clean branch or not in a git directory'
}
