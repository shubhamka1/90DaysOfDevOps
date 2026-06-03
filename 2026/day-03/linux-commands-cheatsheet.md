# Linux Commands Cheat Sheet

## Process Management

| Command                     | Purpose                       |
| --------------------------- | ----------------------------- |
| ps aux                      | List all running processes    |
| ps -ef                      | Detailed process listing      |
| top                         | Real-time resource monitoring |
| pstree                      | View process hierarchy        |
| pgrep <name>                | Find process PID              |
| kill <PID>                  | Terminate process             |
| kill -9 <PID>               | Force terminate process       |
| systemctl status <service>  | Check service status          |
| systemctl restart <service> | Restart service               |
| journalctl -u <service>     | View service logs             |

## File System

| Command | Purpose                 |
| ------- | ----------------------- |
| pwd     | Show current directory  |
| ls -lah | List files with details |
| cd      | Change directory        |
| mkdir   | Create directory        |
| touch   | Create file             |
| cp      | Copy files              |
| mv      | Move or rename files    |
| rm      | Delete files            |
| cat     | Display file contents   |
| less    | View large files        |
| grep    | Search text patterns    |
| find    | Search for files        |
| df -h   | Check disk usage        |
| du -sh  | Check directory size    |

## Networking Troubleshooting

| Command     | Purpose                      |
| ----------- | ---------------------------- |
| ip addr     | View IP addresses            |
| ip route    | View routing table           |
| ping        | Test network connectivity    |
| curl        | Test HTTP/HTTPS connectivity |
| ss -tulpn   | Show listening ports         |
| hostname -I | Show local IP address        |
| nslookup    | DNS lookup                   |
| dig         | Detailed DNS query           |

## System Information

| Command  | Purpose                   |
| -------- | ------------------------- |
| uname -a | Kernel and OS information |
| free -h  | Memory usage              |
| uptime   | System uptime and load    |
| lscpu    | CPU information           |

## Most Used During Troubleshooting

```bash
top
ps aux
systemctl status nginx
journalctl -xe
ss -tulpn
ping google.com
curl https://example.com
df -h
free -h
```

## Why These Matter for DevOps

* Identify failed processes and services.
* Check CPU, memory, and disk usage.
* Troubleshoot network connectivity issues.
* Analyze logs quickly.
* Reduce downtime during production incidents.
