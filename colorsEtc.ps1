# u can see all current colors by running 
# Get-PSReadlineOption
# and setting with 
# Set-PSReadlineOption

$console = $host.ui.rawui

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
Set-PSReadlineOption -TokenKind Type -ForegroundColor Magenta
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

