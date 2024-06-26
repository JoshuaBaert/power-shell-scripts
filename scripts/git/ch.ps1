param (
    [switch] $pull = $false,
    [switch] $noPull = $false
)

$branchName = $args[0]
$branches = git branch

function checkout {
    git checkout $args
    if (($branchName -like "master*" -or $branchName -like "dev*" -or $branchName -like "sandbox*" -or $branchName -like "stage*") -and !$noPull) {
        git pull
    } elseif ($pull) {
        git pull
    }
}

if ($branches -like "*$branchName*") {
    checkout $args
} else {
    $remoteBranches = git ls-remote --heads
    $matchingBranches = $remoteBranches -match ".*$branchName.*"
    echo $matchingBranches

    if (!$matchingBranches) {
        Write-Warning "No Remote.... Want to create $branchName (Y or N)"

        $keyOption = 'Y', 'N'
        while ($keyOption -notcontains $keyPress.Character) {
            $keyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }

        switch ($keyPress.Character) {
            Y { $canCreate = $true }
            N { $canCreate = $false }
            Default { $canCreate = $false }
        }

        if ($canCreate) {
            checkout -b $args
            git push --set-upstream origin $branchName
        }
    } else {
        write 'Checking out remote branch.'
        git fetch
        checkout $args
    }
}
