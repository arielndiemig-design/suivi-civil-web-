$iniPath = "C:\tools\php\php.ini"
$c = Get-Content $iniPath
$c = $c -replace ';extension_dir = "ext"', 'extension_dir = "C:\tools\php\ext"'
$c = $c -replace ';extension=zip', 'extension=zip'
$c = $c -replace ';extension=pdo_mysql', 'extension=pdo_mysql'
Set-Content -Path $iniPath -Value $c
Write-Host "Updated php.ini successfully"
