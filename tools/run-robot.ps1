param([string]$OutputDir = 'results/review')
$ErrorActionPreference = 'Stop'
if (!$env:CHROMEDRIVER) { throw 'Set CHROMEDRIVER first, or run tools/setup.ps1 in this terminal.' }
Push-Location (Join-Path (Split-Path $PSScriptRoot -Parent) 'robot')
try {
    & ./.venv/Scripts/python.exe -m robot -d $OutputDir -v BROWSER:headlesschrome first.robot web_form.robot pizza_scenario.robot
    $testExit = $LASTEXITCODE
} finally { Pop-Location }
exit $testExit
