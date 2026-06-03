# Linux Practice Log - Day 04

## Process Checks

### 1. View Running Processes

```bash
ps -ef
```

Observation:

* PID 1 is systemd.
* nginx master process PID was 222.
* Multiple nginx worker processes were running.

### 2. Monitor System Resources

```bash
top
```

Observation:

* CPU mostly idle (~99% idle).
* Memory usage around 692 MB.
* No zombie processes.

### 3. View Process Tree

```bash
pstree -p
```

Observation:

* systemd is parent of most system services.
* nginx has one master process and multiple worker processes.

---

## Service Checks

### 1. Check Nginx Status

```bash
systemctl status nginx
```

Observation:

* Service was active and running.
* Service enabled at boot.

### 2. List Active Units

```bash
systemctl list-units
```

Observation:

* Viewed active services, mounts, devices, and targets.

### 3. Reload Service

```bash
sudo systemctl reload nginx
```

Observation:

* Configuration reloaded successfully.

### 4. Stop Service

```bash
sudo systemctl stop nginx
```

Observation:

* Service changed to inactive (dead).

### 5. Start Service

```bash
sudo systemctl start nginx
```

Observation:

* Service became active again.

---

## Log Checks

### 1. View Nginx Service Logs

```bash
journalctl -u nginx
```

Observation:

* Found service start, reload, and stop events.

### 2. View System Logs

```bash
journalctl
```

Observation:

* Viewed systemd startup logs and WSL service messages.

### 3. Check Nginx Error Log

```bash
cat /var/log/nginx/error.log
```

Observation:

* No critical errors found.

---

## Resource Checks

### Memory

```bash
free -h
```

Observation:

* 15 GB RAM available.
* 4 GB swap configured.

### Disk

```bash
df -h
```

Observation:

* Root filesystem usage around 1%.
* Windows C: drive mounted under /mnt/c.

### Directory Usage

```bash
du -h
```

Observation:

* Home directory using very little space.

---

## Mini Troubleshooting Exercise

Problem:
Verify nginx service health.

Steps:

1. Check status

```bash
systemctl status nginx
```

2. Review logs

```bash
journalctl -u nginx
```

3. Reload configuration

```bash
sudo systemctl reload nginx
```

4. Stop service

```bash
sudo systemctl stop nginx
```

5. Confirm inactive state

```bash
systemctl status nginx
```

6. Start service

```bash
sudo systemctl start nginx
```

7. Confirm running state

```bash
systemctl status nginx
```

Result:

* Successfully stopped and restarted nginx.
* No errors observed.
* Service functioning normally.
