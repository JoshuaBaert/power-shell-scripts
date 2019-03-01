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

    Set-PSReadlineOption -TokenKind Comment -ForegroundColor DarkGreen
    Set-PSReadlineOption -TokenKind Keyword -ForegroundColor Green
    Set-PSReadlineOption -TokenKind String -ForegroundColor Gray
    Set-PSReadlineOption -TokenKind Operator -ForegroundColor Red
    Set-PSReadlineOption -TokenKind Variable -ForegroundColor Cyan
    Set-PSReadlineOption -TokenKind Command -ForegroundColor Green
    Set-PSReadlineOption -TokenKind Parameter -ForegroundColor Cyan
    Set-PSReadlineOption -TokenKind Type -ForegroundColor Cyan
    Set-PSReadlineOption -TokenKind Number -ForegroundColor White
    Set-PSReadlineOption -TokenKind Member -ForegroundColor White

    Set-PSReadlineOption -TokenKind Comment -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Keyword -BackgroundColor Black
    Set-PSReadlineOption -TokenKind String -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Operator -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Variable -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Command -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Parameter -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Type -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Number -BackgroundColor Black
    Set-PSReadlineOption -TokenKind Member -BackgroundColor Black

    Set-PSReadlineOption -BellStyle None

    Remove-Variable newsize
    Remove-Variable console
}

