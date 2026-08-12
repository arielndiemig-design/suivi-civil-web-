$phpUrl = "https://windows.php.net/downloads/releases/php-8.3.33-Win32-vs16-x64.zip"
$targetDir = "C:\tools\php"
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}
$zipPath = "C:\tools\php.zip"
Write-Host "Downloading PHP 8.3..."
Invoke-WebRequest -Uri $phpUrl -OutFile $zipPath
Write-Host "Extracting PHP..."
Expand-Archive -Path $zipPath -DestinationPath $targetDir -Force
Remove-Item $zipPath

Copy-Item "$targetDir\php.ini-development" "$targetDir\php.ini" -Force
$ini = Get-Content "$targetDir\php.ini"
$ini = $ini -replace ';extension_dir = "ext"', 'extension_dir = "ext"'
$ini = $ini -replace ';extension=curl', 'extension=curl'
$ini = $ini -replace ';extension=fileinfo', 'extension=fileinfo'
$ini = $ini -replace ';extension=mbstring', 'extension=mbstring'
$ini = $ini -replace ';extension=openssl', 'extension=openssl'
$ini = $ini -replace ';extension=pdo_sqlite', 'extension=pdo_sqlite'
$ini = $ini -replace ';extension=sqlite3', 'extension=sqlite3'
$ini = $ini -replace ';extension=pdo_pgsql', 'extension=pdo_pgsql'
$ini = $ini -replace ';extension=pgsql', 'extension=pgsql'
$ini | Set-Content "$targetDir\php.ini"

Write-Host "Downloading Composer..."
Invoke-WebRequest -Uri "https://getcomposer.org/composer.phar" -OutFile "$targetDir\composer.phar"
Set-Content -Path "$targetDir\composer.bat" -Value '@php "%~dp0composer.phar" %*' -Force

Write-Host "Setup complete!"
