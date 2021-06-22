param (
    [switch] $push = $true
)

git add -A
git commit --amend --no-edit -C HEAD
if($push) {
    git push -f
}
