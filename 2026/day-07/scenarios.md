# Linux Troubleshooting Scenarios

These scenarios demonstrate a structured troubleshooting approach used by Linux Administrators, Production Support Engineers, SREs, and DevOps Engineers.

---

# Scenario 1: Service Not Starting

## Problem

A web application service called `myapp` failed to start after a server reboot.

## Step 1: Check Service Status

```bash
systemctl status myapp
```

**Why:**
Determines whether the service is active, inactive, failed, or stuck in a restart loop.

---

## Step 2: Review Service Logs

```bash
journalctl -u myapp -n 50
```

**Why:**
Displays the last 50 log entries and usually reveals the reason for failure.

Common issues:

* Configuration errors
* Missing files
* Permission problems
* Dependency failures

---

## Step 3: Verify Process Existence

```bash
ps -ef | grep myapp
```

**Why:**
Confirms whether the application process is running.

---

## Step 4: Check Boot Configuration

```bash
systemctl is-enabled myapp
```

**Why:**
Determines whether the service is configured to start automatically after reboot.

---

## Step 5: Review Service Configuration

```bash
systemctl cat myapp
```

**Why:**
Displays the service unit file and startup commands.

---

## Step 6: Check for Port Conflicts

```bash
ss -tulpn
```

**Why:**
Identifies whether another process is already using the required port.

---

## Step 7: Verify System Resources

```bash
free -h
df -h
```

**Why:**
A service may fail if memory or disk space is exhausted.

---

## Step 8: Attempt Restart

```bash
sudo systemctl restart myapp
sudo systemctl status myapp
```

**Why:**
Tests whether the issue is temporary and verifies service recovery.

---

## Troubleshooting Flow

```text
Status
 ↓
Logs
 ↓
Process
 ↓
Configuration
 ↓
Ports
 ↓
Resources
 ↓
Restart
```

---

# Scenario 2: High CPU Usage

## Problem

Users report that the application server is slow.

## Step 1: Check Live CPU Usage

```bash
top
```

**Why:**
Displays real-time CPU and memory usage.

Useful keys:

```text
P = Sort by CPU
M = Sort by Memory
q = Quit
```

---

## Step 2: Identify Top CPU Consumers

```bash
ps aux --sort=-%cpu | head -10
```

**Why:**
Lists the top CPU-consuming processes.

Example:

```text
PID     %CPU    COMMAND
3245    85.2    java
1880    22.5    python
```

---

## Step 3: Investigate the Process

```bash
ps -fp <PID>
```

Example:

```bash
ps -fp 3245
```

**Why:**
Shows process owner, start time, and command line.

---

## Step 4: Monitor Specific Process

```bash
top -p <PID>
```

**Why:**
Monitors the suspected process individually.

---

## Step 5: Check System Load

```bash
uptime
```

**Why:**
Displays load averages.

Example:

```text
load average: 8.50, 7.20, 5.60
```

High values may indicate CPU contention.

---

## Step 6: Review CPU Statistics

```bash
vmstat 1 5
```

**Why:**
Provides CPU, memory, and I/O performance metrics.

Important columns:

```text
us = User CPU
sy = System CPU
id = Idle CPU
wa = IO Wait
```

---

## Common Root Causes

* Infinite loops
* Heavy Java applications
* Batch jobs
* Cron jobs
* Database queries
* High user traffic

---

## Troubleshooting Flow

```text
top
 ↓
ps aux --sort=-%cpu
 ↓
Identify PID
 ↓
Investigate Process
 ↓
Check Load
 ↓
Monitor
```

---

# Scenario 3: Finding Service Logs

## Problem

A developer asks:
"Where are the logs for the Docker service?"

The service is managed by systemd.

---

## Step 1: Check Service Status

```bash
systemctl status docker
```

**Why:**
Verifies service state and displays recent log entries.

---

## Step 2: View Recent Logs

```bash
journalctl -u docker -n 50
```

**Why:**
Displays the last 50 log entries for the Docker service.

---

## Step 3: View Logs Since Boot

```bash
journalctl -u docker -b
```

**Why:**
Shows all Docker logs generated since the current reboot.

---

## Step 4: Follow Logs in Real Time

```bash
journalctl -u docker -f
```

**Why:**
Streams logs continuously like `tail -f`.

Exit with:

```text
Ctrl + C
```

---

## Step 5: Display Errors Only

```bash
journalctl -u docker -p err
```

**Why:**
Filters logs to show only error messages.

---

## Step 6: Verify Running Processes

```bash
ps -ef | grep docker
```

**Why:**
Confirms Docker-related processes are running.

---

## Troubleshooting Flow

```text
Service Status
 ↓
Recent Logs
 ↓
Logs Since Boot
 ↓
Follow Logs
 ↓
Error Logs
 ↓
Process Verification
```

---

# Key Commands to Memorize

## Services

```bash
systemctl status <service>
systemctl restart <service>
systemctl is-enabled <service>
systemctl cat <service>
```

## Logs

```bash
journalctl -u <service>
journalctl -u <service> -n 50
journalctl -u <service> -f
journalctl -u <service> -p err
```

## CPU & Processes

```bash
top
ps aux --sort=-%cpu | head
ps -fp <PID>
top -p <PID>
vmstat
uptime
```

## Resources

```bash
free -h
df -h
```

## Network

```bash
ss -tulpn
```

---

# Final Troubleshooting Mindset

For most Linux production incidents, follow this sequence:

```text
Service Down?
    ↓
Check Status
    ↓
Review Logs
    ↓
Verify Process
    ↓
Check Resources
    ↓
Check Network/Ports
    ↓
Restart if Appropriate
    ↓
Confirm Recovery
```

This structured approach is used daily by Linux Administrators, Production Support Engineers, SREs, and DevOps Engineers.
