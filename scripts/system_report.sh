#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

mkdir -p "$LOG_DIR"
REPORT="$LOG_DIR/system_report_$(date +%F_%H%M%S).txt"

{
  echo "System report for $(hostname) generated at $(date --iso-8601=seconds)"
  echo
  echo "---- UPTIME ----"
  uptime
  echo
  echo "---- DISK USAGE ----"
  df -h
  echo
  echo "---- MEMORY ----"
  free -h
  echo
  echo "---- TOP 10 CPU PROCESSES ----"
  ps aux --sort=-%cpu | head -n 11
  echo
  echo "---- TOP 10 MEMORY PROCESSES ----"
  ps aux --sort=-%mem | head -n 11
} > "$REPORT"

echo "✅ Report saved at: $REPORT"
