#  Healthcheck Script

This project contains a simple Bash script `healthcheck.sh` that collects and logs basic system health metrics. It's useful for server monitoring and debugging purposes.

---

##  Features

The script collects the following information:

-  System Date and Time
-  System Uptime
-  CPU Load (from `uptime`)
-  Memory Usage (via `free -m`)
-  Disk Usage (via `df -h`)
-  Top 5 Memory-Consuming Processes
-  Service Status Check for:
  - `nginx`
  - `ssh`

All of the output is logged into a file called `healthlog.txt` with a timestamp.

---

##  How to Use

1. **Clone the repo**  
   ```bash
   git clone https://github.com/Nandini99g/healthcheck-script.git
   cd healthcheck-script
