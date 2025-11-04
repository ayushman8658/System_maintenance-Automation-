#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env.sh"

while true; do
  clear
  echo "=============================================="
  echo "     🔧 System Maintenance Suite Menu"
  echo "=============================================="
  echo "1️⃣  Run Backup"
  echo "2️⃣  Update & Clean System"
  echo "3️⃣  Start Log Monitor"
  echo "4️⃣  Generate System Report"
  echo "5️⃣  Exit"
  echo "----------------------------------------------"
  read -p "Select an option [1-5]: " choice

  case $choice in
    1)
      echo "Running backup..."
      "$HOME/System_maintenance/scripts/backup.sh"
      read -p "Press Enter to continue..."
      ;;
    2)
      echo "Updating and cleaning system..."
      "$HOME/System_maintenance/scripts/update_and_cleanup.sh"
      read -p "Press Enter to continue..."
      ;;
    3)
      echo "Starting log monitor (press Ctrl+C to stop)..."
      "$HOME/System_maintenance/scripts/log_monitor.sh"
      ;;
    4)
      echo "Generating system report..."
      "$HOME/System_maintenance/scripts/system_report.sh"
      read -p "Press Enter to continue..."
      ;;
    5)
      echo "Exiting System Maintenance Suite. Goodbye!"
      exit 0
      ;;
    *)
      echo "❌ Invalid choice. Please select between 1 and 5."
      sleep 2
      ;;
  esac
done
