# My nifty powershell scripts

To get this file working you need to have the folowing file :
`C:\WINDOWS\System32\WindowsPowerShell\v1.0\profile.ps1`
then add these lines to that file:

```
$scriptsDir = 'C:\path\to\this\dir' # <--- Important!!
Import-Module $scriptsDir\_profile.ps1
```

### Config.ps1 Vars Declared 
* $excludedDirs
* $preferedDir
