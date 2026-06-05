# Day 08 - Cloud Deployment with Nginx

## Objective

Deploy a real web server on a cloud VM, connect via SSH, install Nginx, verify internet accessibility, and collect server logs.

---

## Cloud Platform

* Provider: AWS EC2
* Operating System: Ubuntu Server
* Web Server: Nginx

---

## Step 1: Connect to EC2 Instance

Connected to the EC2 instance using SSH.

```bash
ssh -i my-key.pem ubuntu@ec2-44-243-85-170.us-west-2.compute.amazonaws.com
```

### Screenshot Required

* SSH session connected to the server.

---

## Step 2: Update Package Repository

```bash
sudo apt-get update
```

---

## Step 3: Install Nginx

```bash
sudo apt install nginx
```

Verify the service is running:

```bash
systemctl status nginx
```

---

## Step 4: Configure Security Group

Configured the AWS EC2 Security Group to allow inbound HTTP traffic.

| Type | Protocol | Port |
| ---- | -------- | ---- |
| HTTP | TCP      | 80   |

This allows users to access the web server from the internet.

---

## Step 5: Verify Website Access

Opened the EC2 public IP address in a browser:

```text
http://44.243.85.170
```

Verified that the default Nginx Welcome Page was displayed successfully.

### Screenshot Required

* Nginx Welcome Page in browser.

---

## Step 6: Collect Nginx Logs

### View Nginx Service Logs

```bash
journalctl -u nginx
```

Save service logs:

```bash
journalctl -u nginx > nginx-logs.txt
```

Verify contents:

```bash
cat nginx-logs.txt
```

### View Nginx Access Logs

```bash
sudo cat /var/log/nginx/access.log
```

Sample output:

```text
103.248.73.237 - - [05/Jun/2026:06:00:28 +0000] "GET / HTTP/1.1" 200 409 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36"

103.248.73.237 - - [05/Jun/2026:06:00:28 +0000] "GET /favicon.ico HTTP/1.1" 404 197 "http://44.243.85.170/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36"
```

Explanation:

* `GET /` = Request for the website homepage.
* `200` = Successful response.
* `GET /favicon.ico` = Browser requested a favicon.
* `404` = Favicon not found (normal for default Nginx page).

### Save Access Logs to a File

```bash
sudo cat /var/log/nginx/access.log > access-log.txt
```

Verify contents:

```bash
cat access-log.txt
```

---

## Step 7: Transfer Log File to Local Machine

Transferred the access log file from the EC2 server to the local machine using SCP.

```bash
scp -i my-key.pem ubuntu@ec2-44-243-85-170.us-west-2.compute.amazonaws.com:~/access-log.txt .
```

Transfer completed successfully.

---

## Commands Executed

```bash
sudo apt-get update
sudo apt install nginx
journalctl -u nginx
journalctl -u nginx > nginx-logs.txt
cat nginx-logs.txt
sudo cat /var/log/nginx/access.log
sudo cat /var/log/nginx/access.log > access-log.txt
cat access-log.txt
scp -i my-key.pem ubuntu@ec2-44-243-85-170.us-west-2.compute.amazonaws.com:~/access-log.txt .
```

---

## Deliverables

### Files

* day-08-cloud-deployment.md
* access-log.txt
* nginx-logs.txt (optional)

### Screenshots

1. SSH connection to the EC2 instance.
2. Nginx Welcome Page displayed in a browser.
3. Output of `cat access-log.txt`.

---

## Outcome

Successfully launched an AWS EC2 instance, connected via SSH, installed and configured Nginx, opened port 80 for public access, verified the website from the internet, collected Nginx service and access logs, and transferred the log file to the local machine for submission.
