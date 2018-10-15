$message = git status

if($message -like '*nothing to commit, working tree clean*') {    
    git checkout master
    git pull
    git checkout -
    git merge master
} else {
    Write-Warning 'Not working on a clean branch'
}
