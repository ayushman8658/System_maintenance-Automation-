#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"        # load configuration
trap 'echo "[$(date --iso-8601=seconds)] ERROR at $0:$LINENO" >> "$LOG_DIR/error.log"' ERR

TIMESTAMP=$(date +%F_%H%M%S)
HOST=$(hostname -s)
ARCHIVE="${BACKUP_DIR}/${HOST}_backup_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR" "$LOG_DIR"

# Directories to back up (you can add more paths)
DIRS_TO_BACKUP=(/etc "$HOME")

echo "[$(date --iso-8601=seconds)] Starting backup to $ARCHIVE" >> "$LOG_DIR/backup.log"

tar -czpf "$ARCHIVE" "${DIRS_TO_BACKUP[@]}" 2>>"$LOG_DIR/backup.log"

# Delete old backups
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +"$RETAIN_DAYS" -print -delete >> "$LOG_DIR/backup.log" 2>&1

echo "[$(date --iso-8601=seconds)] Backup completed: $ARCHIVE" >> "$LOG_DIR/backup.log"
echo "✅ Backup created: $ARCHIVE"
