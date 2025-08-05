#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="healthlog.txt"

{
  echo "======================================"
  echo " System Health Check – $TIMESTAMP"
  echo "======================================"
  
  echo ""
  echo " Date & Time:"
  date
  
  echo ""
  echo " Uptime:"
  uptime
  
  echo ""
  echo " CPU Load:"
  uptime | awk -F'load average:' '{ print $2 }'
  
  echo ""
  echo " Memory Usage (MB):"
  free -m
  
  echo ""
  echo " Disk Usage:"
  df -h
  
  echo ""
  echo " Top 5 Memory‑Consuming Processes:"
  ps aux --sort=-%mem | head -n 6
  
  echo ""
  echo " Service Status:"
  
  for svc in nginx sshd; do
    if pgrep ${svc} > /dev/null; then
      echo "  ${svc} is running"
    else
      echo "  ${svc} is NOT running"
    fi
  done
  
  echo "======================================"
  echo ""
} >> "$LOGFILE"

echo " Health check complete. Logged to $LOGFILE"
