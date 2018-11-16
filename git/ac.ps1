$commitMessage = $args[0]

if(!$commitMessage) {
    $commitMessage = Read-Host -Prompt 'Add Commit Message'
}

git add .
git commit -m "$commitMessage"
git push