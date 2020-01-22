param($minutes = 60)

Clear-Host
echo "Keep-alive with Scroll Lock..."

$WShell = New-Object -com "Wscript.Shell"

while ($true) {
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -Milliseconds 100
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -Seconds 300
  echo "Flipping ScrollLock"
}
