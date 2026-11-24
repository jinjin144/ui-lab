param([string]$ChromePath = "$env:LOCALAPPDATA/Google/Chrome/Application/chrome.exe")
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
if (!(Test-Path -LiteralPath $ChromePath)) { throw "Chrome not found: $ChromePath. Supply -ChromePath." }
$version = (Get-Item -LiteralPath $ChromePath).VersionInfo.ProductVersion
# Keep the downloaded driver outside the repository.
$driverRoot = Join-Path ([IO.Path]::GetTempPath()) "ui-lab-driver-$version"
New-Item -ItemType Directory -Force $driverRoot | Out-Null
$zip = Join-Path $driverRoot 'chromedriver.zip'
Invoke-WebRequest "https://storage.googleapis.com/chrome-for-testing-public/$version/win64/chromedriver-win64.zip" -OutFile $zip
Expand-Archive -LiteralPath $zip -DestinationPath $driverRoot -Force
$env:CHROMEDRIVER = Join-Path $driverRoot 'chromedriver-win64/chromedriver.exe'
Write-Host "CHROMEDRIVER=$env:CHROMEDRIVER"
Write-Host 'This variable is set for this terminal. Re-run setup in a new terminal.'
& $env:CHROMEDRIVER --version
$robotRoot = Join-Path $repoRoot 'robot'
python -m venv (Join-Path $robotRoot '.venv')
& (Join-Path $robotRoot '.venv/Scripts/python.exe') -m pip install -r (Join-Path $robotRoot 'requirements-lock.txt')
if ($LASTEXITCODE -ne 0) { throw 'Robot dependency installation failed.' }
Push-Location (Join-Path $repoRoot 'cypress')
try {
    npm.cmd ci
    if ($LASTEXITCODE -ne 0) { throw 'Cypress dependency installation failed.' }
    npx.cmd cypress install
    if ($LASTEXITCODE -ne 0) { throw 'Cypress runtime installation failed.' }
} finally { Pop-Location }
