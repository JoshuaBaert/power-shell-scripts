param (
    [switch] $push = $true
)

$commitMessage = $args[0]

if (!$commitMessage) {
    $commitMessage = Read-Host -Prompt 'Add Commit Message'
}

git add -A
git commit -m "$commitMessage"
if ($push) {
    git push
}

