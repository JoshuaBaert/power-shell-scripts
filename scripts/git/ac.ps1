param (
    [switch] $noPush = $false
)

$commitMessage = $args[0]

if (!$commitMessage) {
    $commitMessage = Read-Host -Prompt 'Add Commit Message'
}

git add -A
git commit -m "$commitMessage"
if (!$noPush) {
    git push
}

