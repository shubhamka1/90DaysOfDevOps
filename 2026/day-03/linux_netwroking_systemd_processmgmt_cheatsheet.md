Here's a **one-page Linux + DevOps Troubleshooting Cheat Sheet** focused on the commands you've learned and should practice daily.

# Linux & DevOps Quick Reference Cheat Sheet

## File System

```bash
pwd                     # Current directory
ls -la                  # List files with details
cd /path                # Change directory
mkdir testdir           # Create directory
touch file.txt          # Create file
cp src dst              # Copy file
mv old new              # Move/Rename file
rm file.txt             # Delete file
find /etc -name "*.conf" # Find files
```

---

## File Content

```bash
cat file.txt            # Display file
less file.txt           # Read large file
head -10 file.txt       # First 10 lines
tail -10 file.txt       # Last 10 lines
tail -f logfile.log     # Live log monitoring
grep nginx file.txt     # Search text
wc -l file.txt          # Count lines
```

---

## Permissions

```bash
ls -l                   # View permissions
chmod 755 script.sh     # Change permissions
chmod +x script.sh      # Make executable
chown user:user file    # Change ownership
```

---

## Process Management

```bash
ps aux                  # All processes
ps -ef                  # Detailed process list
top                     # Live process monitoring
pstree                  # Process tree
pgrep nginx             # Find PID
kill PID                # Stop process
kill -9 PID             # Force kill
```

---

## Memory & CPU

```bash
free -h                 # Memory usage
swapon --show           # Swap usage
cat /proc/meminfo       # Detailed memory info
lscpu                   # CPU details
uptime                  # System load
```

---

## Disk Usage

```bash
df -h                   # Filesystem usage
du -sh .                # Current directory size
du -sh /var/log         # Log size
```

---

## System Information

```bash
uname -a                # Kernel info
hostname                # Hostname
hostnamectl             # System details
cat /etc/os-release     # OS version
date                    # Current date/time
```

---

## Users

```bash
whoami                  # Current user
id                      # User ID
groups                  # User groups
```

---

## Systemd & Services

```bash
systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx
systemctl list-units --type=service
systemctl --failed
```

### Logs

```bash
journalctl
journalctl -u nginx
journalctl -n 50
journalctl -p err
```

---

## Networking

### IP Address

```bash
ip addr
hostname -I
```

### Routing

```bash
ip route
ip route get 8.8.8.8
```

### DNS

```bash
cat /etc/resolv.conf
nslookup google.com
dig google.com
```

---

## Connectivity Testing

### ICMP

```bash
ping google.com
ping 8.8.8.8
```

Tests:
DNS → ICMP Reachability

---

### TCP

```bash
telnet google.com 443
nc -vz google.com 443
```

Tests:
DNS → TCP

---

### TLS

```bash
openssl s_client -connect google.com:443
```

Tests:
DNS → TCP → TLS → Certificate

---

### HTTP/HTTPS

```bash
curl https://google.com
curl -I https://google.com
curl -v https://google.com
curl -L https://google.com
```

Tests:
DNS → TCP → TLS → HTTP

---

## Ports & Services

```bash
ss -tulpn
ss -tulpn | grep :80
```

Common Ports:

| Port | Service    |
| ---- | ---------- |
| 22   | SSH        |
| 53   | DNS        |
| 80   | HTTP       |
| 443  | HTTPS      |
| 3306 | MySQL      |
| 5432 | PostgreSQL |

---

## Nginx

```bash
systemctl status nginx
nginx -t
curl http://localhost
```

Important Files:

```bash
/etc/nginx/nginx.conf
/var/www/html/index.html
```

---

# DevOps Troubleshooting Flow

Website not working?

### 1. DNS

```bash
nslookup domain.com
```

### 2. Routing

```bash
ip route
```

### 3. Connectivity

```bash
ping domain.com
```

### 4. TCP

```bash
telnet domain.com 443
```

### 5. TLS

```bash
openssl s_client -connect domain.com:443
```

### 6. HTTP

```bash
curl -v https://domain.com
```

Flow:

DNS
↓
Route
↓
TCP
↓
TLS
↓
HTTP
↓
Application

---

# Daily DevOps Practice Commands

```bash
ip addr
ip route
nslookup google.com
curl -v https://google.com
ss -tulpn
ps aux
free -h
df -h
systemctl status nginx
journalctl -u nginx
```

Goal:
Be able to explain every line of output from these commands.

This is the cheat sheet I'd keep open while learning Linux, networking, systemd, Nginx, and DevOps troubleshooting.
