#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/update.log"

# Trap any errors
trap 'echo "[$(date --iso-8601=seconds)] ERROR at $0:$LINENO" >> "$LOG_DIR/error.log"' ERR

echo "[$(date --iso-8601=seconds)] Starting system update" >> "$LOG"

# For Ubuntu / Debian
if command -v apt >/dev/null 2>&1; then
  sudo apt update >> "$LOG" 2>&1
  sudo DEBIAN_FRONTEND=noninteractive apt -y upgrade >> "$LOG" 2>&1
  sudo apt -y autoremove >> "$LOG" 2>&1
  sudo apt -y autoclean >> "$LOG" 2>&1

# For RHEL / Fedora / CentOS
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf -y upgrade >> "$LOG" 2>&1
  sudo dnf -y autoremove >> "$LOG" 2>&1

elif command -v yum >/dev/null 2>&1; then
  sudo yum -y update >> "$LOG" 2>&1
fi

echo "[$(date --iso-8601=seconds)] System update completed" >> "$LOG"
echo "✅ Update completed — see logs in $LOG"
