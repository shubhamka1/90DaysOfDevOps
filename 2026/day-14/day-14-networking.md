# Day 14 - Networking Basics & Troubleshooting

## Objective

Understand core networking concepts and practice common troubleshooting commands used in Linux and DevOps environments.

---

# Quick Concepts

## OSI vs TCP/IP

| OSI Model    | TCP/IP Model |
| ------------ | ------------ |
| Application  | Application  |
| Presentation | Application  |
| Session      | Application  |
| Transport    | Transport    |
| Network      | Internet     |
| Data Link    | Link         |
| Physical     | Link         |

### Notes

* OSI is a conceptual 7-layer model used for learning and troubleshooting.
* TCP/IP is the practical model used on the Internet.

---

## Where Common Protocols Sit

| Protocol   | Layer            |
| ---------- | ---------------- |
| HTTP/HTTPS | Application      |
| DNS        | Application      |
| TCP/UDP    | Transport        |
| IP         | Network/Internet |
| Ethernet   | Data Link/Link   |

### Example

```text
curl https://example.com

Application: HTTPS
Transport: TCP (port 443)
Internet: IP
Link: Ethernet/Wi-Fi
```

This is Application Layer traffic running over TCP, which is carried by IP across the network.

---

# Hands-on Checklist

## 1. Identity

### Command

```bash
hostname -I
```

### Output

```text
<your-ip-address>
```

### Observation

* Displays the system's assigned IP address.
* Useful for verifying network configuration.

---

## 2. Reachability

### Command

```bash
ping -c 4 google.com
```

### Output

```text
4 packets transmitted, 4 received, 0% packet loss
rtt min/avg/max = 12.3/15.1/20.4 ms
```

### Observation

* Host is reachable.
* No packet loss observed.
* Average latency around 15 ms.

---

## 3. Path Discovery

### Command

```bash
tracepath google.com
```

or

```bash
traceroute google.com
```

### Observation

* Multiple hops observed between source and destination.
* A few timeout hops may appear due to firewall filtering.
* High latency hops can indicate routing issues.

---

## 4. Listening Ports

### Command

```bash
ss -tulpn
```

### Output (Example)

```text
tcp LISTEN 0 511 0.0.0.0:80
```

### Observation

* Nginx is listening on port 80.
* Service is accepting incoming HTTP connections.

---

## 5. Name Resolution

### Command

```bash
dig google.com
```

or

```bash
nslookup google.com
```

### Output

```text
google.com has address 142.x.x.x
```

### Observation

* DNS resolution successful.
* Domain name translated into an IP address.

---

## 6. HTTP Check

### Command

```bash
curl -I https://google.com
```

### Output

```text
HTTP/2 200
```

### Observation

* HTTP request successful.
* Status code 200 indicates healthy service.

---

## 7. Connections Snapshot

### Command

```bash
netstat -an | head
```

### Observation

* LISTEN entries indicate services waiting for connections.
* ESTABLISHED entries indicate active network sessions.

Approximate Count:

```text
LISTEN: <count>
ESTABLISHED: <count>
```

---

# Target Host

Selected Target:

```text
google.com
```

Used for:

* ping
* traceroute/tracepath
* dig/nslookup
* curl

---

# Mini Task: Port Probe & Interpret

## Identify Listening Port

### Command

```bash
ss -tulpn
```

Example:

```text
tcp LISTEN 0 511 *:80
```

Port Identified:

```text
80 (HTTP)
```

---

## Test Connectivity

### Command

```bash
nc -zv localhost 80
```

or

```bash
curl -I http://localhost:80
```

### Result

```text
Connection successful
```

### Observation

* Port is reachable locally.
* Service is accepting requests.

If not reachable:

Next checks:

```bash
systemctl status nginx
sudo ufw status
sudo journalctl -u nginx
```

---

# Reflection

## Which command gives the fastest signal when something is broken?

`ping`

Reason:

* Quickly verifies basic connectivity and packet loss.

---

## If DNS fails, what layer would you inspect next?

Application Layer

Checks:

```bash
dig google.com
cat /etc/resolv.conf
systemd-resolve --status
```

---

## If HTTP 500 appears, what layer would you inspect next?

Application Layer

Checks:

```bash
curl -I URL
journalctl -u nginx
tail -f /var/log/nginx/error.log
```

---

## Two Follow-Up Checks During a Real Incident

### Check Service Health

```bash
systemctl status <service>
```

Verify the application is running.

### Check Listening Ports

```bash
ss -tulpn
```

Confirm the application is listening on the expected port.

---

# Summary

Learned:

* OSI and TCP/IP layer mapping.
* DNS resolution basics.
* Connectivity verification using ping, traceroute, curl, dig, ss, and netstat.
* Port verification using nc and localhost testing.
* Basic troubleshooting workflow for networking incidents.
