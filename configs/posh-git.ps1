
if (Test-Path 'C:\tools\posh-git\src\posh-git.psm1') {
    Import-Module C:\tools\posh-git\src\posh-git.psm1

    $GitPromptSettings.DefaultPromptWriteStatusFirst = $true
    $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $false
    $GitPromptSettings.PathStatusSeparator = '`n'
    $GitPromptSettings.IndexColor.ForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.BeforeIndex.ForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.WorkingColor.ForegroundColor = [ConsoleColor]::Magenta
    $GitPromptSettings.LocalWorkingStatusSymbol.ForegroundColor = [ConsoleColor]::Red

    function prompt { return & $GitPromptScriptBlock }
}
