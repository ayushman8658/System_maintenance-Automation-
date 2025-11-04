# 🧰 System Maintenance Automation Suite (BashScripting Project)

A complete **Bash Scripting Suite** that automates essential Linux system maintenance tasks.  
Developed as part of the Capstone Project — *Bash Scripting Suite for System Maintenance*.

---

## 📖 Overview

This suite automates four major system tasks:
1. **Backup Automation** – Safely creates timestamped system backups.  
2. **System Update & Cleanup** – Keeps your OS updated and clean.  
3. **Log Monitoring & Alerts** – Watches system logs for errors.  
4. **System Reports** – Generates detailed system health reports.  

All tasks are accessible through an **interactive menu interface**.
---

## ⚙️ Features

- 🗄️ **Automated Backups** — Compresses `/etc` and `/home` for safe restore.  
- 🔄 **System Update & Cleanup** — Keeps packages fresh and cleans unused ones.  
- 🚨 **Log Monitoring** — Detects `error`, `failed`, or `panic` messages in real-time.  
- 📊 **System Reports** — Summarizes CPU, RAM, and disk usage for analysis.  
- 🧭 **Interactive Menu** — One central script for all maintenance actions.  
- 🧰 **Logging & Error Handling** — Every script logs its output in `logs/`.

---

``` 🗂 Folder Structure
System_maintenance/
├── backups/               # Stores backup archives (.tar.gz)
├── logs/                  # Stores log files and reports
│   ├── backup.log
│   ├── update.log
│   ├── alerts.log
│   ├── error.log
│   └── system_report_*.txt
└── scripts/               # All Bash scripts
    ├── env.sh
    ├── backup.sh
    ├── update_and_cleanup.sh
    ├── log_monitor.sh
    ├── system_report.sh
    └── maintenance_menu.sh
