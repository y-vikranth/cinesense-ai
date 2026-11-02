# Run CineSense AI React Frontend
$env:PATH = "C:\Program Files\nodejs;" + $env:PATH
Write-Host "Starting CineSense AI React Frontend on http://localhost:3000 ..." -ForegroundColor Cyan
Set-Location frontend
& "C:\Program Files\nodejs\npm.cmd" run dev

