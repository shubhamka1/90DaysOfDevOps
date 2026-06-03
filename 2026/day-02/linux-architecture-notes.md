# Linux Architecture Notes

## 1. Core Components of Linux

### Kernel

* Core of the operating system.
* Manages CPU, memory, processes, devices, and filesystems.
* Acts as a bridge between hardware and applications.
* Runs in **kernel space** with full privileges.

### User Space

* Where user applications and commands run.
* Examples: bash, nginx, docker, vim.
* Cannot directly access hardware; requests go through the kernel using system calls.

### Init / Systemd

* First process started by the kernel (PID 1).
* Responsible for starting and managing system services.
* Handles boot process, service monitoring, logging, and shutdown.

---

## 2. Process Creation and Management

### Process Creation

* A process is a running instance of a program.
* New processes are usually created using `fork()`.
* The child process may execute a new program using `exec()`.

### Process States

* **Running (R)** – Currently executing on CPU.
* **Sleeping (S)** – Waiting for an event or resource.
* **Stopped (T)** – Paused by user or debugger.
* **Zombie (Z)** – Process finished but parent has not collected its exit status.
* **Idle/Waiting** – Waiting for CPU scheduling.

### Process Monitoring

Useful commands:

* `ps aux` – View running processes.
* `top` – Real-time process monitoring.
* `htop` – Interactive process viewer.
* `kill <PID>` – Terminate a process.
* `pstree` – View parent-child process relationships.

---

## 3. What Systemd Does

### Responsibilities

* Starts services during boot.
* Tracks and manages running services.
* Restarts failed services if configured.
* Collects logs through journald.
* Controls system targets such as multi-user and graphical modes.

### Why It Matters

As a DevOps engineer, systemd helps you:

* Diagnose failed services quickly.
* Check service status and logs.
* Configure automatic service startup.
* Troubleshoot application crashes and restarts.

Common commands:

```bash
systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
journalctl -u nginx
```

## 4. Five Linux Commands Used Daily

```bash
ps aux          # View processes
top             # Monitor CPU and memory usage
systemctl       # Manage services
journalctl      # View logs
ls -la          # List files and permissions
ss -tulpn # Check listening ports
```

---

## Linux Boot Process

```text
Power On
   ↓
BIOS/UEFI
   ↓
GRUB Bootloader
   ↓
Linux Kernel
   ↓
Initramfs
   ↓
Mount Root Filesystem
   ↓
systemd (PID 1)
   ↓
Start Services
   ↓
Login Prompt / GUI
```

### Boot Stages

1. **BIOS/UEFI** – Detects hardware and finds boot device.
2. **GRUB** – Loads kernel and initramfs.
3. **Kernel** – Initializes CPU, memory, and drivers.
4. **Initramfs** – Loads required drivers and finds root filesystem.
5. **Systemd** – Starts services and completes system startup.




## Summary

* The **Kernel** manages hardware and system resources.
* **User Space** runs applications and user commands.
* **Systemd (PID 1)** manages boot, services, and logging.
* Processes move through states such as running, sleeping, and zombie.
* Understanding processes and systemd is essential for troubleshooting Linux systems in DevOps environments.
