# u can see all current colors by running
# Get-PSReadlineOption
# and setting with
# Set-PSReadlineOption

if (Get-Module -ListAvailable -Name PSReadLine) {
    $console = $host.ui.rawui

    $desiredWidth = 170

    $newsize = $console.buffersize
    if ( $newsize.width -le $desiredWidth) {
        $newsize.width = $desiredWidth
        $console.buffersize = $newsize
    }

    $newsize = $console.windowsize
    $newsize.height = 45
    $newsize.width = $desiredWidth
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


#    Set-PSReadLineOption -Colors @{
#        Comment = "`e[32;40m"
#        Keyword = "`e[92;40m"
#        String = "`e[37;40m"
#        Operator = "`e[91;40m"
#        Variable = "`e[96;40m"
#        Command = "`e[92;40m"
#        Parameter = "`e[96;40m"
#        Type = "`e[96;40m"
#        Number = "`e[97;40m"
#        Member = "`e[97;40m"
#    }

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

