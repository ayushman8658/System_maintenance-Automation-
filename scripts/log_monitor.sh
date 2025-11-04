#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

LOGFILE="/var/log/syslog"                # main system log
ALERT_LOG="$LOG_DIR/alerts.log"
KEYWORDS=("error" "failed" "panic" "segfault")

mkdir -p "$LOG_DIR"
trap 'echo "[$(date --iso-8601=seconds)] ERROR at $0:$LINENO" >> "$LOG_DIR/error.log"' ERR

echo "[$(date --iso-8601=seconds)] Starting log monitor for $LOGFILE" >> "$ALERT_LOG"

# if /var/log/syslog not found (e.g. Fedora), use journalctl
if [[ ! -f "$LOGFILE" && -x "$(command -v journalctl)" ]]; then
  journalctl -f -o short-iso | while read -r line; do
    lower=$(echo "$line" | tr 'A-Z' 'a-z')
    for kw in "${KEYWORDS[@]}"; do
      if echo "$lower" | grep -q "$kw"; then
        echo "[$(date --iso-8601=seconds)] ALERT: $line" >> "$ALERT_LOG"
        [[ -n "${ALERT_EMAIL:-}" ]] && echo "$line" | mail -s "Log Alert: $kw on $(hostname)" "$ALERT_EMAIL"
        break
      fi
    done
  done
else
  tail -F "$LOGFILE" | while read -r line; do
    lower=$(echo "$line" | tr 'A-Z' 'a-z')
    for kw in "${KEYWORDS[@]}"; do
      if echo "$lower" | grep -q "$kw"; then
        echo "[$(date --iso-8601=seconds)] ALERT: $line" >> "$ALERT_LOG"
        [[ -n "${ALERT_EMAIL:-}" ]] && echo "$line" | mail -s "Log Alert: $kw on $(hostname)" "$ALERT_EMAIL"
        break
      fi
    done
  done
fi
