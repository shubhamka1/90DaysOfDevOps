# Day 09 - Linux User & Group Management Challenge

## Objective

Practice Linux user and group administration by creating users, groups, assigning memberships, managing permissions, and setting up shared workspaces.

---

# Task 1: Create Users

Created the following users with home directories and passwords:

* tokyo
* berlin
* professor

Commands:

```bash
sudo useradd -m tokyo
sudo passwd tokyo

sudo useradd -m berlin
sudo passwd berlin

sudo useradd -m professor
sudo passwd professor
```

Verification:

```bash
cat /etc/passwd
ls -l /home
```

---

# Task 2: Create Groups

Created two groups:

* developers
* admins

Commands:

```bash
sudo groupadd developers
sudo groupadd admins
```

Verification:

```bash
cat /etc/group
```

---

# Task 3: Assign Users to Groups

Assignments:

| User      | Primary Group | Additional Groups |
| --------- | ------------- | ----------------- |
| tokyo     | developers    | None              |
| berlin    | developers    | admins            |
| professor | admins        | None              |

Commands:

```bash
sudo usermod -g developers tokyo

sudo usermod -g developers -aG admins berlin

sudo usermod -g admins professor
```

Verification:

```bash
id tokyo
id berlin
id professor

groups tokyo
groups berlin
groups professor
```

---

# Task 4: Shared Directory

Created shared development directory:

```bash
sudo mkdir /opt/dev-project
```

Set group ownership:

```bash
sudo chgrp developers /opt/dev-project
```

Set permissions:

```bash
sudo chmod 775 /opt/dev-project
```

Verify:

```bash
ls -ld /opt/dev-project
```

Test file creation:

```bash
sudo -u tokyo touch /opt/dev-project/tokyo.txt

sudo -u berlin touch /opt/dev-project/berlin.txt
```

Verify:

```bash
ls -l /opt/dev-project
```

---

# Task 5: Team Workspace

Created user:

```bash
sudo useradd -m nairobi
sudo passwd nairobi
```

Created group:

```bash
sudo groupadd project-team
```

Added users:

```bash
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```

Created workspace:

```bash
sudo mkdir /opt/team-workspace
```

Assigned group:

```bash
sudo chgrp project-team /opt/team-workspace
```

Set permissions:

```bash
sudo chmod 775 /opt/team-workspace
```

Verification:

```bash
ls -ld /opt/team-workspace
```

Test as nairobi:

```bash
sudo -u nairobi touch /opt/team-workspace/test.txt
```

Verify:

```bash
ls -l /opt/team-workspace
```

---

# Users & Groups Created

Users:

* tokyo
* berlin
* professor
* nairobi

Groups:

* developers
* admins
* project-team

---

# Group Membership Summary

| User      | Groups                   |
| --------- | ------------------------ |
| tokyo     | developers, project-team |
| berlin    | developers, admins       |
| professor | admins                   |
| nairobi   | project-team             |

---

# Directories Created

| Directory           | Group Owner  | Permissions |
| ------------------- | ------------ | ----------- |
| /opt/dev-project    | developers   | 775         |
| /opt/team-workspace | project-team | 775         |

---

# Commands Used

## User Management

```bash
useradd
adduser
passwd
usermod
id
groups
```

## Group Management

```bash
groupadd
chgrp
```

## Permission Management

```bash
chmod
ls -ld
```

## Verification

```bash
cat /etc/passwd
cat /etc/group
grep
id
groups
```

## Testing

```bash
sudo -u username command
touch
```

---

# Command Flags Learned

## useradd

| Flag | Meaning               |
| ---- | --------------------- |
| -m   | Create home directory |
| -s   | Set login shell       |
| -g   | Primary group         |
| -G   | Supplementary groups  |
| -p   | Encrypted password    |

Example:

```bash
sudo useradd -m -s /bin/bash user1
```

---

## usermod

| Flag | Meaning                     |
| ---- | --------------------------- |
| -g   | Change primary group        |
| -G   | Set supplementary groups    |
| -a   | Append supplementary groups |
| -s   | Change login shell          |

Example:

```bash
sudo usermod -g developers -aG admins berlin
```

---

## chmod

| Permission  | Value |
| ----------- | ----- |
| Read (r)    | 4     |
| Write (w)   | 2     |
| Execute (x) | 1     |

Example:

```bash
chmod 775 directory
```

Meaning:

```text
Owner = rwx (7)
Group = rwx (7)
Others = r-x (5)
```

---

## sudo

| Flag | Meaning                         |
| ---- | ------------------------------- |
| -u   | Execute command as another user |

Example:

```bash
sudo -u tokyo touch file.txt
```

---

# Additional Concepts Learned

## Difference Between useradd and adduser

### useradd

* Low-level command
* Used in scripts and automation
* Requires more manual options

Example:

```bash
sudo useradd -m user1
sudo passwd user1
```

### adduser

* Friendly Ubuntu wrapper
* Interactive
* Automatically creates home directory and prompts for password

Example:

```bash
sudo adduser user1
```

---

## Difference Between GID and Groups

Primary Group:

Stored in:

```bash
/etc/passwd
```

Example:

```text
tokyo:x:1001:1002
```

GID 1002 = developers

Supplementary Groups:

Stored in:

```bash
/etc/group
```

Example:

```text
admins:x:1003:berlin
```

Berlin belongs to admins as an additional group.

---

## Important Files

### User Database

```bash
/etc/passwd
```

Contains:

* Username
* UID
* GID
* Home directory
* Login shell

### Group Database

```bash
/etc/group
```

Contains:

* Group name
* Group ID
* Supplementary members

---

# What I Learned

1. How Linux stores user information in `/etc/passwd` and group information in `/etc/group`.
2. Difference between primary groups (GID) and supplementary groups.
3. How permissions and group ownership control access to shared directories.
4. Difference between `useradd` and `adduser`.
5. How to verify user and group assignments using `id` and `groups`.
6. How to test permissions using `sudo -u`.
7. How shared directories can be managed using group ownership and `chmod 775`.

---

# Outcome

Successfully created users and groups, assigned memberships, configured shared directories, managed permissions, tested access using multiple users, and gained practical experience with Linux user and group administration.
