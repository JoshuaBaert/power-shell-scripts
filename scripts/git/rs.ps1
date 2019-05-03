

$branchName = $args[0]
$commitMessage = $args[1]
$status = git status

if ($branchName -eq $null) {
    Write-Warning 'You need a branch name as first argument'
    exit
}

if ($commitMessage -eq $null) {
    $commitMessage = Read-Host -Prompt 'Commit message?' 
}

if ([string]::IsNullOrEmpty($commitMessage)) {
    Write-Warning 'Actually you need a commit message'
    exit
}

if ($status -like '*nothing to commit, working tree clean*') {
    Write-Error 'Not working on a clean branch'
    exit
} else {
    Write-Warning "Have you already merged $branchName (Y or N)"

    $keyOption = 'Y','N'
    while ($keyOption -notcontains $keyPress.Character) {
        $keyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }

    switch ($keyPress.Character) {
        Y { $canSquash = $true }
        N { $canSquash = $false }
        Default { $canSquash = $false }
    }

    if ($canSquash) {
        Write-Warning "Squashing Branch!! & Pushing forcefully"
        git reset --soft $branchName
        git commit -m $commitMessage
        git push -f
    } else {
        Write-Warning "Did NOT squash your branch"
    }
}
