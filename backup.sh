#!/bin/bash

# === CONFIGURATION ===
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_ROOT="./backups/backup_$TIMESTAMP"
LOGFILE="./backup.log"
COMPRESS=false
remote=false
recent=""
nolog=false
FILES_TO_BACKUP=()
mkdir -p "$BACKUP_ROOT"

# === PARSE ARGUMENTS ===
for ARG in "$@"; do
    if [[ "$ARG" == "--compress" ]]; then
        COMPRESS=true
    else
        FILES_TO_BACKUP+=("$ARG")
    fi
done

# === CREATE BACKUP DIRECTORY ===
mkdir -p "$BACKUP_ROOT"

# === START LOG ===
{
echo "---------------------------------------------"
echo " Backup Log - $TIMESTAMP"
echo "Target Folder: $BACKUP_ROOT"
} >> "$LOGFILE"

# === BACKUP LOGIC ===
VALID_FILES=()
for FILE in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$FILE" ]; then
        echo " Found: $FILE" >> "$LOGFILE"
        if [ "$COMPRESS" = false ]; then
            FILENAME=$(basename "$FILE")
            cp "$FILE" "$BACKUP_ROOT/${FILENAME}.bak"
            echo " Backed up $FILE → ${FILENAME}.bak" >> "$LOGFILE"
        else
            VALID_FILES+=("$FILE")
        fi
    else
        echo " Not Found: $FILE" >> "$LOGFILE"
    fi
done

# === COMPRESS IF FLAGGED ===
if [ "$COMPRESS" = true ] && [ ${#VALID_FILES[@]} -gt 0 ]; then
    TARFILE="$BACKUP_ROOT/backup_$TIMESTAMP.tar.gz"
    tar -czf "$TARFILE" "${VALID_FILES[@]}" 2>>"$LOGFILE"
    echo " Compressed archive created: $TARFILE" >> "$LOGFILE"
fi

echo " Backup complete. Details logged to $LOGFILE"
