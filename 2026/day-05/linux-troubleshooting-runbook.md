# Linux Troubleshooting Runbook

## Target Service / Process

**Target Service:** SSH (sshd)

### Environment Basics

**Command:**

```bash
uname -a
```

**Observation:**
Server is running Linux on x86_64 architecture with a stable kernel version. No obvious kernel-related issues observed.

**Command:**

```bash
cat /etc/os-release
```

**Observation:**
Host is running a supported Linux distribution and version. Environment information verified successfully.

### Filesystem Sanity

**Command:**

```bash
mkdir /tmp/runbook-demo
```

**Observation:**
Successfully created a test directory, confirming filesystem write access and normal permissions.

**Command:**

```bash
cp /etc/hosts /tmp/runbook-demo && ls -l /tmp/runbook-demo
```

**Observation:**
File copy and directory listing completed successfully. Basic filesystem operations are functioning normally.

---

## Snapshot: CPU & Memory

**Command:**

```bash
free -h
```

**Observation:**
Memory utilization is within acceptable limits with sufficient available RAM. No indication of memory pressure or excessive swapping.

**Command:**

```bash
ps -o pid,pcpu,pmem,comm -p <PID>
```

**Observation:**
Target process is running and consuming minimal CPU and memory resources. No abnormal resource utilization detected.

---

## Snapshot: Disk & IO

**Command:**

```bash
df -h
```

**Observation:**
Filesystem usage is healthy with adequate free disk space available. No risk of disk exhaustion at this time.

**Command:**

```bash
du -sh /var/log
```

**Observation:**
Log directory size is reasonable and not contributing significantly to overall disk consumption.

---

## Snapshot: Network

**Command:**

```bash
ss -tulpn
```

**Observation:**
Required services are listening on expected network ports. No missing listeners or network binding issues observed.

**Command:**

```bash
curl -I http://localhost
```

**Observation:**
Service endpoint responded successfully, confirming application availability and network connectivity.

---

## Logs Reviewed

**Command:**

```bash
journalctl -u ssh -n 50
```

**Observation:**
Recent service logs reviewed. No critical errors, crashes, or repeated failures detected.

**Command:**

```bash
tail -n 50 /var/log/auth.log
```

**Observation:**
Authentication logs show normal activity with no unusual login attempts or security concerns.

---

## Quick Findings

* System is healthy and responsive.
* CPU and memory utilization are within normal operating ranges.
* Disk space is sufficient with no storage-related concerns.
* Network services are accessible and listening on expected ports.
* Log review did not reveal any critical errors or recurring failures.
* No immediate remediation actions are required.

---

## If This Worsens (Next Steps)

1. Capture additional diagnostics using `top`, `vmstat`, and `iostat` during the incident window.
2. Increase logging verbosity and collect extended `journalctl` and application log output.
3. Restart the affected service and investigate recurring issues using `strace`, network diagnostics, and deeper log analysis.


# Additional Troubleshooting Commands

## Process Investigation

### Find Process ID

```bash
pgrep sshd
```

**Observation:** Verified that the target service process is running and obtained its PID.

### Detailed Process Information

```bash
ps -ef | grep sshd
```

**Observation:** Confirmed process owner, start time, and command arguments.

### Real-Time Process Monitoring

```bash
top
```

**Observation:** Reviewed system load and identified top CPU and memory consumers.

---

## CPU & Memory Analysis

### Virtual Memory Statistics

```bash
vmstat 1 5
```

**Observation:** CPU, memory, and I/O activity remained within normal operating ranges.

### Memory Usage by Process

```bash
ps aux --sort=-%mem | head
```

**Observation:** Identified the highest memory-consuming processes on the system.

### CPU Usage by Process

```bash
ps aux --sort=-%cpu | head
```

**Observation:** Identified the highest CPU-consuming processes on the system.

---

## Disk & Filesystem Analysis

### Largest Directories

```bash
du -sh /* 2>/dev/null | sort -hr | head
```

**Observation:** Identified directories consuming the most disk space.

### Mounted Filesystems

```bash
mount | column -t
```

**Observation:** Verified mounted filesystems and mount options.

### Open Files

```bash
lsof | head
```

**Observation:** Reviewed files currently opened by running processes.

---

## Network Analysis

### Active Network Connections

```bash
ss -tunap
```

**Observation:** Verified active TCP/UDP connections and listening services.

### DNS Resolution Test

```bash
nslookup google.com
```

**Observation:** DNS resolution functioning correctly.

### Connectivity Test

```bash
ping -c 4 google.com
```

**Observation:** External network connectivity verified successfully.

### Route Verification

```bash
ip route
```

**Observation:** Default gateway and routing configuration appear correct.

### Interface Status

```bash
ip addr show
```

**Observation:** Network interfaces are up and configured with valid IP addresses.

---

## Log Investigation

### System Logs

```bash
journalctl -xe
```

**Observation:** Reviewed recent system events and error messages.

### Kernel Logs

```bash
dmesg | tail -50
```

**Observation:** No hardware, disk, or kernel-related errors detected.

### Search for Errors

```bash
grep -i error /var/log/syslog | tail -20
```

**Observation:** No recurring critical errors found in recent logs.

---

## Service Management

### Service Status

```bash
systemctl status ssh
```

**Observation:** Service is active and running normally.

### Service Dependencies

```bash
systemctl list-dependencies ssh
```

**Observation:** Required service dependencies are available and healthy.

---

## Useful Production Commands

### Check Server Uptime

```bash
uptime
```

**Observation:** Server uptime is stable with acceptable load averages.

### Logged-In Users

```bash
who
```

**Observation:** Verified active user sessions.

### Last Logins

```bash
last | head
```

**Observation:** Reviewed recent user login history.

### Environment Variables

```bash
env
```

**Observation:** Verified runtime environment configuration.

### Cron Jobs

```bash
crontab -l
```

**Observation:** Confirmed scheduled jobs configured for the current user.
