#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="healthlog.txt"

{
  echo "======================================" >> $LOGFILE
  echo " System Health Check – $TIMESTAMP" >> $LOGFILE
  echo "======================================" >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " Date & Time:" >> $LOGFILE
  date >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " Uptime:" >> $LOGFILE
  uptime >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " CPU Load:" >> $LOGFILE
  uptime | awk -F'load average:' '{ print $2 }' >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " Memory Usage (MB):" >> $LOGFILE
  free -m >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " Disk Usage:" >> $LOGFILE
  df -h >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " Top 5 Memory‑Consuming Processes:" >> $LOGFILE
  ps aux --sort=-%mem | head -n 6 >> $LOGFILE
  
  echo "" >> $LOGFILE
  echo " Service Status:" >> $LOGFILE
  
  if [ "$#" -eq 0 ]; then
    echo "No services were specified to check." >> $LOGFILE
else
    echo "Service Status:" >> $LOGFILE
    for SERVICE in "$@"; do
        # Check if any running process contains the service name
        if ps aux | grep -v grep | grep -w "$SERVICE" &> /dev/null; then
            echo "$SERVICE: running" >> $LOGFILE
        else
            echo "$SERVICE: not running or not found" >> $LOGFILE
        fi
    done
fi
  
  echo "======================================" >> $LOGFILE
  echo "" >> $LOGFILE
} >> "$LOGFILE"

echo " Health check complete. Logged to $LOGFILE"
