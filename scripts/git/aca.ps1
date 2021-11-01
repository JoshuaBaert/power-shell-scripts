param (
    [switch] $noPush = $false
)

git add -A
git commit --amend --no-edit -C HEAD
if(!$noPush) {
    git push --force
}
