$commitMessage = $args[0]
$status = git status

if ($commitMessage -eq $null) {
    Write-Warning 'You need to pass a commit message'
} elseif ($message -like '*nothing to commit, working tree clean*') {
    Write-Error 'Not working on a clean branch'
} else {
    Write-Warning "Have you already merged Master? (Y or N)"

    $keyOption = 'Y','N'
    while ($keyOption -notcontains $keyPress.Character) {
        $keyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }

    switch ($keyPress.Character) {
        Y { $canSquash = $true }
        N { $canSquash = $false }
        Default { $canSquash = $false }
    }

    if($canSquash) {
        Write-Warning "Squashing Branch!! & Pushing forcefully"
        git reset --soft master
        git commit -m $commitMessage
        git push -f
    } else {
        Write-Warning "Did NOT squash your branch"
    }
}
