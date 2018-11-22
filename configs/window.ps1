$pshost = get-host

$pswindow = $pshost.ui.rawui

$newsize = $pswindow.buffersize
$newsize.height = 3000
$newsize.width = 140
$pswindow.buffersize = $newsize

$newsize = $pswindow.windowsize
$newsize.height = 50
$newsize.width = 140
$pswindow.windowsize = $newsize

Remove-Variable $pshost
Remove-Variable $pswindow
Remove-Variable $newsize