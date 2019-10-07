# u can see all current colors by running
# Get-PSReadlineOption
# and setting with
# Set-PSReadlineOption

if (Get-Module -ListAvailable -Name PSReadLine) {
    $console = $host.ui.rawui

    $newsize = $console.buffersize
    if ( $newsize.width -le 140) {
        $newsize.width = 140
        $console.buffersize = $newsize
    }

    $newsize = $console.windowsize
    $newsize.height = 45
    $newsize.width = 140
    $console.windowsize = $newsize

    $console.backgroundcolor = "Black"
    $console.foregroundcolor = "White"

    $colors = $host.privatedata

    $colors.VerboseForegroundColor = "White"
    $colors.ProgressForegroundColor = "White"
    $colors.DebugForegroundColor = "White"
    $colors.WarningForegroundColor = "Yellow"
    $colors.ErrorForegroundColor = "Red"

    $colors.VerboseBackgroundColor = "Black"
    $colors.ProgressBackgroundColor = "Black"
    $colors.DebugBackgroundColor = "Black"
    $colors.WarningBackgroundColor = "Black"
    $colors.ErrorBackgroundColor = "Black"

    Set-PSReadLineOption -Colors @{
        Comment = [ConsoleColor]::DarkGreen
        Keyword = [ConsoleColor]::Green
        String = [ConsoleColor]::Gray
        Operator = [ConsoleColor]::Red
        Variable = [ConsoleColor]::Cyan
        Command = [ConsoleColor]::Green
        Parameter = [ConsoleColor]::Cyan
        Type = [ConsoleColor]::Cyan
        Number = [ConsoleColor]::White
        Member = [ConsoleColor]::White
    }

#    Set-PSReadLineOption -BackgroundColor -Colors @{
#        Comment = [ConsoleColor]::Black
#        Keyword = [ConsoleColor]::Black
#        String = [ConsoleColor]::Black
#        Operator = [ConsoleColor]::Black
#        Variable = [ConsoleColor]::Black
#        Command = [ConsoleColor]::Black
#        Parameter = [ConsoleColor]::Black
#        Type = [ConsoleColor]::Black
#        Number = [ConsoleColor]::Black
#        Member = [ConsoleColor]::Black
#    }

    Set-PSReadlineOption -BellStyle None

    Remove-Variable newsize
    Remove-Variable console
}

