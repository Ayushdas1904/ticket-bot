#!/usr/bin/env bash
# Run the checker on your own computer every N minutes (macOS / Linux).
#   ./run_local.sh        (default: every 3 minutes)
#   ./run_local.sh 5      (every 5 minutes)
# Needs a .env file next to this script with TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID.
set -u
cd "$(dirname "$0")"
MIN="${1:-3}"
[ -f .env ] || { echo "Missing .env (see README-local.md)"; exit 1; }
set -a; . ./.env; set +a
command -v uv >/dev/null || { echo "Install uv first: curl -LsSf https://astral.sh/uv/install.sh | sh"; exit 1; }
uv sync --frozen -q
echo "Checking every $MIN min. Ctrl+C to stop."
while true; do
  uv run -q main.py
  sleep $((MIN * 60))
done
