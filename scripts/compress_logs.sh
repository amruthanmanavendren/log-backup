#!/bin/bash

# ==============================
# AUTO-DETECT PROJECT DIRECTORY
# ==============================
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ==============================
# CONFIGURATION
# ==============================
LOG_DIR="/var/log/myapp"
BACKUP_DIR="$PROJECT_DIR/log-backup/backups"
LOG_FILE="$PROJECT_DIR/log-backup/backup.log"

DATE=$(date +%F)
ARCHIVE_NAME="myapp-logs-$DATE.tar.gz"
S3_BUCKET="s3://django-log-backup/myapp-logs/$DATE/"

AWS_CMD="/usr/local/bin/aws"

# ==============================
# CREATE DIRECTORIES
# ==============================
mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# ==============================
# START PROCESS
# ==============================
echo "-----------------------------" >> "$LOG_FILE"
echo "$(date): Backup started" >> "$LOG_FILE"

# ==============================
# CHECK LOG FILES
# ==============================
if [ -d "$LOG_DIR" ] && [ "$(ls -A $LOG_DIR 2>/dev/null)" ]; then

    # Compress logs
    tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

    if [ $? -eq 0 ]; then
        echo "$(date): Compression successful" >> "$LOG_FILE"
    else
        echo "$(date): Compression FAILED" >> "$LOG_FILE"
        exit 1
    fi

    # Upload to S3
    $AWS_CMD s3 cp "$BACKUP_DIR/$ARCHIVE_NAME" "$S3_BUCKET"

    if [ $? -eq 0 ]; then
        echo "$(date): Upload to S3 SUCCESS" >> "$LOG_FILE"
    else
        echo "$(date): Upload to S3 FAILED" >> "$LOG_FILE"
        exit 1
    fi

else
    echo "$(date): No logs found in $LOG_DIR" >> "$LOG_FILE"
fi

echo "$(date): Backup completed" >> "$LOG_FILE"