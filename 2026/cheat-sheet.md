# Linux & DevOps Master Cheat Sheet (Days 1–11)

## Navigation & Directory Commands

| Command   | Purpose                | Important Flags | Example             |
| --------- | ---------------------- | --------------- | ------------------- |
| `pwd`     | Show current directory | —               | `pwd`               |
| `ls`      | List files/directories | `-l -a -h -R`   | `ls -lah`           |
| `cd`      | Change directory       | —               | `cd /home/ubuntu`   |
| `mkdir`   | Create directory       | `-p`            | `mkdir -p app/logs` |
| `rmdir`   | Remove empty directory | —               | `rmdir testdir`     |
| `clear`   | Clear terminal screen  | —               | `clear`             |
| `history` | Show command history   | —               | `history`           |

---

## File Operations

| Command | Purpose                       | Important Flags | Example                     |
| ------- | ----------------------------- | --------------- | --------------------------- |
| `touch` | Create empty file             | —               | `touch notes.txt`           |
| `cp`    | Copy files/directories        | `-r`            | `cp -r app backup`          |
| `mv`    | Move/rename files             | —               | `mv old.txt new.txt`        |
| `rm`    | Delete files/directories      | `-r -f`         | `rm -rf project`            |
| `cat`   | Display file contents         | —               | `cat notes.txt`             |
| `less`  | View large files page-by-page | —               | `less logfile.txt`          |
| `head`  | Show first lines of file      | `-n`            | `head -n 5 /etc/passwd`     |
| `tail`  | Show last lines/follow logs   | `-n -f`         | `tail -f access.log`        |
| `echo`  | Print text/write to file      | `> >>`          | `echo "Hello" > file.txt`   |
| `grep`  | Search text patterns          | `-i -n -r`      | `grep -i error logfile.txt` |
| `find`  | Search files/directories      | `-name -type`   | `find /home -name "*.txt"`  |

---

## Vim Basics

| Action              | Command           |
| ------------------- | ----------------- |
| Open file           | `vim file.txt`    |
| Read-only mode      | `vim -R file.txt` |
| Read-only shortcut  | `view file.txt`   |
| Insert mode         | `i`               |
| Save                | `:w`              |
| Quit                | `:q`              |
| Save & Quit         | `:wq`             |
| Quit without saving | `:q!`             |

---

## User Management

| Command   | Purpose                    | Important Flags | Example                          |
| --------- | -------------------------- | --------------- | -------------------------------- |
| `useradd` | Create user (low-level)    | `-m -s -g -G`   | `sudo useradd -m tokyo`          |
| `adduser` | Interactive user creation  | `--shell`       | `sudo adduser tokyo`             |
| `passwd`  | Set/change password        | —               | `sudo passwd tokyo`              |
| `usermod` | Modify existing user       | `-g -G -a -s`   | `sudo usermod -aG admins berlin` |
| `whoami`  | Show current user          | —               | `whoami`                         |
| `id`      | Show UID, GID and groups   | —               | `id tokyo`                       |
| `groups`  | Show user group membership | —               | `groups berlin`                  |

### Common User Commands

```bash id="5m8jau"
sudo useradd -m tokyo
sudo passwd tokyo

sudo usermod -g developers tokyo
sudo usermod -aG admins berlin

sudo usermod -s /bin/bash nairobi
```

---

## Group Management

| Command    | Purpose            | Example                          |
| ---------- | ------------------ | -------------------------------- |
| `groupadd` | Create group       | `sudo groupadd developers`       |
| `chgrp`    | Change file group  | `sudo chgrp developers file.txt` |
| `groups`   | Show user's groups | `groups tokyo`                   |

---

## File Permissions

### Permission Values

| Number | Meaning |
| ------ | ------- |
| `7`    | `rwx`   |
| `6`    | `rw-`   |
| `5`    | `r-x`   |
| `4`    | `r--`   |
| `3`    | `-wx`   |
| `2`    | `-w-`   |
| `1`    | `--x`   |
| `0`    | `---`   |

### Common Permission Modes

| Mode  | Meaning     |
| ----- | ----------- |
| `755` | `rwxr-xr-x` |
| `775` | `rwxrwxr-x` |
| `644` | `rw-r--r--` |
| `640` | `rw-r-----` |
| `600` | `rw-------` |

### chmod

| Command          | Purpose                                |
| ---------------- | -------------------------------------- |
| `chmod +x file`  | Add execute permission                 |
| `chmod -x file`  | Remove execute permission              |
| `chmod +w file`  | Add write permission                   |
| `chmod -w file`  | Remove write permission                |
| `chmod a-w file` | Remove write for everyone              |
| `chmod 755 dir`  | Owner full access, others read/execute |
| `chmod 775 dir`  | Shared team directory                  |
| `chmod 640 file` | Owner RW, group R                      |

### Examples

```bash id="f7icqf"
chmod +x script.sh
chmod 755 project
chmod 775 shared
chmod 640 notes.txt
```

---

## File Ownership

| Command                   | Purpose                          | Important Flags | Example                                     |
| ------------------------- | -------------------------------- | --------------- | ------------------------------------------- |
| `chown user file`         | Change owner only                | `-R`            | `sudo chown tokyo file.txt`                 |
| `chown user:group file`   | Change owner and group           | `-R`            | `sudo chown tokyo:developers file.txt`      |
| `chown :group file`       | Change group only using chown    | `-R`            | `sudo chown :developers file.txt`           |
| `chgrp group file`        | Change group only                | `-R`            | `sudo chgrp developers file.txt`            |
| `chown -R user:group dir` | Recursive owner and group change | `-R`            | `sudo chown -R professor:planners project/` |

### Ownership Example

```text id="r0lq48"
-rw-r--r-- 1 tokyo developers file.txt
             ↑      ↑
          Owner   Group
```

### Owner vs Group

| Owner                  | Group                              |
| ---------------------- | ---------------------------------- |
| User who owns the file | Group associated with the file     |
| Only one owner         | Multiple users can belong to group |
| Changed using `chown`  | Changed using `chgrp` or `chown`   |
| Stored as UID          | Stored as GID                      |

### Quick Ownership Rules

```bash id="t5vfd8"
sudo chown tokyo file.txt
sudo chgrp developers file.txt
sudo chown :developers file.txt
sudo chown tokyo:developers file.txt
sudo chown -R professor:planners project/
```

---

## Process Management

| Command   | Purpose                | Example        |
| --------- | ---------------------- | -------------- |
| `ps`      | Show running processes | `ps aux`       |
| `top`     | Live process monitor   | `top`          |
| `kill`    | Stop process           | `kill 1234`    |
| `kill -9` | Force stop process     | `kill -9 1234` |

---

## Service Management (systemd)

| Command                     | Purpose               |
| --------------------------- | --------------------- |
| `systemctl status service`  | Check service status  |
| `systemctl start service`   | Start service         |
| `systemctl stop service`    | Stop service          |
| `systemctl restart service` | Restart service       |
| `systemctl enable service`  | Start service on boot |

### Examples

```bash id="3lq8y5"
sudo systemctl status nginx
sudo systemctl restart nginx
sudo systemctl enable nginx
```

---

## Logs

| Command                       | Purpose           |
| ----------------------------- | ----------------- |
| `journalctl -u service`       | View service logs |
| `journalctl -u service -n 50` | Last 50 log lines |
| `journalctl -f`               | Follow logs live  |
| `tail -f logfile`             | Follow file logs  |

### Examples

```bash id="jtydfo"
journalctl -u nginx
journalctl -u nginx -n 50
tail -f /var/log/nginx/access.log
```

---

## Networking

| Command    | Purpose              | Example           |
| ---------- | -------------------- | ----------------- |
| `ip a`     | Show IP addresses    | `ip a`            |
| `ip route` | Show routing table   | `ip route`        |
| `ping`     | Test connectivity    | `ping google.com` |
| `ss`       | Show listening ports | `sudo ss -tulpn`  |

### ss Flags

| Flag | Meaning   |
| ---- | --------- |
| `-t` | TCP       |
| `-u` | UDP       |
| `-l` | Listening |
| `-p` | Process   |
| `-n` | Numeric   |

Example:

```bash id="wmj4sg"
sudo ss -tulpn | grep :80
```

---

## SSH & File Transfer

| Command          | Purpose         | Example                                  |
| ---------------- | --------------- | ---------------------------------------- |
| `ssh`            | Remote login    | `ssh ubuntu@server`                      |
| `ssh -i key.pem` | Login using key | `ssh -i my-key.pem ubuntu@server`        |
| `scp`            | Secure copy     | `scp file.txt server:/tmp`               |
| `scp -i key.pem` | SCP using key   | `scp -i my-key.pem file.txt server:/tmp` |

---

## Nginx Commands

| Command                         | Purpose         |
| ------------------------------- | --------------- |
| `sudo apt install nginx`        | Install Nginx   |
| `systemctl status nginx`        | Check status    |
| `systemctl restart nginx`       | Restart service |
| `journalctl -u nginx`           | Service logs    |
| `cat /var/log/nginx/access.log` | Access logs     |
| `cat /var/log/nginx/error.log`  | Error logs      |

---

## Important Linux Files

| File                        | Purpose                |
| --------------------------- | ---------------------- |
| `/etc/passwd`               | User database          |
| `/etc/group`                | Group database         |
| `/etc/shadow`               | Password hashes        |
| `/var/log/nginx/access.log` | Nginx access logs      |
| `/var/log/nginx/error.log`  | Nginx error logs       |
| `/etc/hosts`                | Local hostname mapping |

---

## Common Interview Questions

| Question                                    | Answer                                                                                  |
| ------------------------------------------- | --------------------------------------------------------------------------------------- |
| Difference between `useradd` and `adduser`? | `useradd` is low-level and script-friendly, `adduser` is interactive and user-friendly. |
| Difference between `chown` and `chgrp`?     | `chown` changes owner, group, or both; `chgrp` changes only group.                      |
| Difference between owner and group?         | Owner is a single user; group is a collection of users.                                 |
| How to change owner and group together?     | `sudo chown user:group file`                                                            |
| How to change ownership recursively?        | `sudo chown -R user:group directory`                                                    |
| Difference between GID and Groups?          | GID = primary group, Groups = all group memberships.                                    |
| How to view ownership?                      | `ls -l file`                                                                            |
| How to view user groups?                    | `id username` or `groups username`                                                      |

---

## Daily DevOps Troubleshooting Workflow

### 1. Check Current Location

```bash id="9i5m5x"
pwd
ls -lah
```

### 2. Check Service Status

```bash id="j2c6te"
systemctl status nginx
```

### 3. Check Logs

```bash id="z2zlnz"
journalctl -u nginx
tail -f /var/log/nginx/access.log
```

### 4. Check Permissions & Ownership

```bash id="67jlwm"
ls -l
ls -ld directory
```

### 5. Check User & Groups

```bash id="jpnm4f"
id username
groups username
```

### 6. Check Running Processes

```bash id="jlwmwn"
ps aux
top
```

### 7. Check Network

```bash id="8f0fry"
ip a
ss -tulpn
ping google.com
```

### 8. Verify Remote Access

```bash id="3svbh1"
ssh user@server
scp file.txt user@server:/tmp
```

---

## Most Used Commands (Remember These)

```bash id="hd0pk4"
pwd
ls -lah
cd
mkdir -p
touch
cat
grep
find
chmod
chown
chgrp
useradd
usermod
groupadd
id
groups
ps aux
top
systemctl status
journalctl -u <service>
tail -f <logfile>
ip a
ss -tulpn
ssh
scp
history
```
