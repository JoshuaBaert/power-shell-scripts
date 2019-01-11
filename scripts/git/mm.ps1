param (
    [switch] $noPush = $false
)

$message = git status

if($message -like '*nothing to commit, working tree clean*') {    
    git checkout master
    git pull
    git checkout -
    $mergeMessage = git merge master

    $status = git status
    if($status -like '*Your branch is ahead of*' -And $status -like '*Your branch is ahead of*') {
        if(!$noPush) {
            Write-Host 'Pushing the merge up'
            git push
        }

        if($mergeMessage -imatch 'package\.json\s*\|\s*\d*' ){
            Write-Host 'Installing new packages'
            npm install
        }
    }
} else {
    Write-Warning 'Not working on a clean branch or not in a git directory'
}
