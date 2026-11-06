# Run the checker on your own computer every N minutes (Windows PowerShell).
#   .\run_local.ps1          (default: every 3 minutes)
#   .\run_local.ps1 -Min 5
# Needs a .env file next to this script with TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID.
param([int]$Min = 3)
Set-Location $PSScriptRoot
if (-not (Test-Path .env)) { Write-Host "Missing .env (see README-local.md)"; exit 1 }
Get-Content .env | ForEach-Object {
  if ($_ -match '^\s*([A-Z_]+)\s*=\s*(.+?)\s*$') { [Environment]::SetEnvironmentVariable($Matches[1], $Matches[2]) }
}
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
  Write-Host 'Install uv first: powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"'; exit 1 }
uv sync --frozen -q
Write-Host "Checking every $Min min. Ctrl+C to stop."
while ($true) {
  uv run -q main.py
  Start-Sleep -Seconds ($Min * 60)
}
