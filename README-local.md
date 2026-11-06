# Run on your own laptop

BookMyShow blocks GitHub's servers (HTTP 403), so the checker has to run from a home
internet connection. The laptop must be on, awake and online while it checks.

## One-time setup

1. Install **git** and **uv**:
   - macOS / Linux: `curl -LsSf https://astral.sh/uv/install.sh | sh`
   - Windows (PowerShell): `powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"`
2. Get the code:
   ```
   git clone https://github.com/Ayushdas1904/ticket-bot.git
   cd ticket-bot
   ```
3. Create `.env` from the template and put your bot token in it (never commit this file):
   - macOS / Linux: `cp .env.example .env`, then edit `.env`
   - Windows: `copy .env.example .env`, then `notepad .env`

## Run

- macOS / Linux: `./run_local.sh` (every 3 min) or `./run_local.sh 5`
- Windows: `.\run_local.ps1` or `.\run_local.ps1 -Min 5`
  (if scripts are blocked: `powershell -ExecutionPolicy Bypass -File .\run_local.ps1`)

Each run prints e.g. `ramayana-hyderabad: no showtimes listed yet` or `N matching showtimes`.
`HTTP 403` means BookMyShow is blocking this network (VPN / office Wi-Fi) – use home Wi-Fi.

## Keep it running

- macOS: run `caffeinate -i ./run_local.sh` so the Mac doesn't sleep (lid open, on charger).
- Windows: Settings → System → Power → Screen and sleep → "Never" while plugged in.
- Closing the terminal stops it. Ctrl+C stops it too.

## Change what to watch

Edit `trackers.json` (dates as `YYYYMMDD`, theatre = part of the name, formats like
`"dolby cinema 3d"`, `"imax 3d"`, times `morning` / `afternoon` / `evening` / `night`).
The next check picks it up – no restart needed.
