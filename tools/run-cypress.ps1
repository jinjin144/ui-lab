param([string]$ChromePath = "$env:LOCALAPPDATA/Google/Chrome/Application/chrome.exe")
$ErrorActionPreference = 'Stop'
if (!(Test-Path -LiteralPath $ChromePath)) { throw "Chrome not found: $ChromePath. Supply -ChromePath." }
Push-Location (Join-Path (Split-Path $PSScriptRoot -Parent) 'cypress')
try {
    npx.cmd cypress run --browser $ChromePath
    $testExit = $LASTEXITCODE
} finally { Pop-Location }
exit $testExit
