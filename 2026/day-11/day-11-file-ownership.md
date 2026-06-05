# Day 11 - File Ownership Challenge (chown & chgrp)

## Objective

Learn how Linux file ownership works, how to change file owners and groups, and how to apply ownership changes recursively across directories.

---

# Task 1: Understanding Ownership

List files in the home directory:

```bash
ls -l
```

Example output:

```text
-rw-r--r-- 1 ubuntu ubuntu 125 Jun 5 devops-file.txt
```

Format:

```text
-rw-r--r-- 1 owner group size date filename
```

Example:

```text
-rw-r--r-- 1 ubuntu ubuntu 125 Jun 5 devops-file.txt
              ↑      ↑
           owner   group
```

### Difference Between Owner and Group

**Owner**

* The user who owns the file.
* Usually has the highest level of control.

**Group**

* A collection of users who can share access to files.
* Permissions assigned to the group apply to all members of that group.

Verification:

```bash
whoami
ls -l
```

---

# Task 2: Basic chown Operations

## Create File

```bash
touch devops-file.txt
```

Check ownership:

```bash
ls -l devops-file.txt
```

Example:

```text
-rw-r--r-- 1 ubuntu ubuntu 0 Jun 5 devops-file.txt
```

---

## Change Owner to Tokyo

```bash
sudo chown tokyo devops-file.txt
```

Verify:

```bash
ls -l devops-file.txt
```

Output:

```text
-rw-r--r-- 1 tokyo ubuntu 0 Jun 5 devops-file.txt
```

---

## Change Owner to Berlin

```bash
sudo chown berlin devops-file.txt
```

Verify:

```bash
ls -l devops-file.txt
```

Output:

```text
-rw-r--r-- 1 berlin ubuntu 0 Jun 5 devops-file.txt
```

---

# Task 3: Basic chgrp Operations

## Create File

```bash
touch team-notes.txt
```

Check ownership:

```bash
ls -l team-notes.txt
```

---

## Create Group

```bash
sudo groupadd heist-team
```

Verify:

```bash
grep heist-team /etc/group
```

---

## Change Group

```bash
sudo chgrp heist-team team-notes.txt
```

Verify:

```bash
ls -l team-notes.txt
```

Output:

```text
-rw-r--r-- 1 ubuntu heist-team 0 Jun 5 team-notes.txt
```

---

# Task 4: Combined Owner & Group Change

## Create File

```bash
touch project-config.yaml
```

Change owner and group together:

```bash
sudo chown professor:heist-team project-config.yaml
```

Verify:

```bash
ls -l project-config.yaml
```

Output:

```text
-rw-r--r-- 1 professor heist-team 0 Jun 5 project-config.yaml
```

---

## Create Directory

```bash
mkdir app-logs
```

Change owner and group:

```bash
sudo chown berlin:heist-team app-logs
```

Verify:

```bash
ls -ld app-logs
```

Output:

```text
drwxr-xr-x 2 berlin heist-team 4096 Jun 5 app-logs
```

---

# Task 5: Recursive Ownership

## Create Directory Structure

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
```

---

## Create Group

```bash
sudo groupadd planners
```

---

## Apply Recursive Ownership

```bash
sudo chown -R professor:planners heist-project
```

Explanation:

```text
-R = Recursive
```

Changes ownership of:

* heist-project
* vault
* plans
* gold.txt
* strategy.conf

---

## Verify

```bash
ls -lR heist-project
```

Expected:

```text
heist-project:
drwxr-xr-x professor planners vault
drwxr-xr-x professor planners plans

heist-project/vault:
-rw-r--r-- professor planners gold.txt

heist-project/plans:
-rw-r--r-- professor planners strategy.conf
```

---

# Task 6: Practice Challenge

## Create Groups

```bash
sudo groupadd vault-team
sudo groupadd tech-team
```

Verify:

```bash
grep vault-team /etc/group
grep tech-team /etc/group
```

---

## Create Directory

```bash
mkdir bank-heist
```

---

## Create Files

```bash
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```

---

## Assign Ownership

### access-codes.txt

```bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
```

### blueprints.pdf

```bash
sudo chown berlin:tech-team bank-heist/blueprints.pdf
```

### escape-plan.txt

```bash
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

---

## Verify

```bash
ls -l bank-heist
```

Expected:

```text
-rw-r--r-- 1 tokyo   vault-team access-codes.txt
-rw-r--r-- 1 berlin  tech-team  blueprints.pdf
-rw-r--r-- 1 nairobi vault-team escape-plan.txt
```

---

# Files & Directories Created

Files:

* devops-file.txt
* team-notes.txt
* project-config.yaml
* heist-project/vault/gold.txt
* heist-project/plans/strategy.conf
* bank-heist/access-codes.txt
* bank-heist/blueprints.pdf
* bank-heist/escape-plan.txt

Directories:

* app-logs
* heist-project
* heist-project/vault
* heist-project/plans
* bank-heist

Groups:

* heist-team
* planners
* vault-team
* tech-team

---

# Ownership Changes

| File/Directory      | Before        | After                |
| ------------------- | ------------- | -------------------- |
| devops-file.txt     | ubuntu:ubuntu | tokyo:ubuntu         |
| devops-file.txt     | tokyo:ubuntu  | berlin:ubuntu        |
| team-notes.txt      | ubuntu:ubuntu | ubuntu:heist-team    |
| project-config.yaml | ubuntu:ubuntu | professor:heist-team |
| app-logs            | ubuntu:ubuntu | berlin:heist-team    |
| heist-project       | ubuntu:ubuntu | professor:planners   |
| access-codes.txt    | ubuntu:ubuntu | tokyo:vault-team     |
| blueprints.pdf      | ubuntu:ubuntu | berlin:tech-team     |
| escape-plan.txt     | ubuntu:ubuntu | nairobi:vault-team   |

---

# Commands Used

## Ownership Commands

```bash
chown
chgrp
```

## File Operations

```bash
touch
mkdir
ls
```

## Verification

```bash
ls -l
ls -ld
ls -lR
grep
```

---

# Command Flags Learned

## chown

### Change Owner

```bash
sudo chown user file
```

Example:

```bash
sudo chown tokyo devops-file.txt
```

---

### Change Owner and Group

```bash
sudo chown owner:group file
```

Example:

```bash
sudo chown professor:heist-team project-config.yaml
```

---

### Change Group Only Using chown

```bash
sudo chown :group file
```

Example:

```bash
sudo chown :heist-team team-notes.txt
```

---

### Recursive Ownership

```bash
sudo chown -R owner:group directory
```

Example:

```bash
sudo chown -R professor:planners heist-project
```

---

## chgrp

### Change Group

```bash
sudo chgrp group file
```

Example:

```bash
sudo chgrp heist-team team-notes.txt
```

---

# Difference Between chown and chgrp

| Command | Purpose                           |
| ------- | --------------------------------- |
| chown   | Change owner and optionally group |
| chgrp   | Change group only                 |

Examples:

```bash
sudo chown tokyo file.txt
sudo chown tokyo:developers file.txt

sudo chgrp developers file.txt
```

---

# Additional Concepts Learned

## Ownership vs Permissions

Ownership determines:

* Who owns the file
* Which group owns the file

Permissions determine:

* Who can read
* Who can write
* Who can execute

Example:

```text
-rw-r--r-- 1 tokyo developers file.txt
```

Ownership:

```text
Owner = tokyo
Group = developers
```

Permissions:

```text
Owner = rw-
Group = r--
Others = r--
```

---

## View Current User

```bash
whoami
```

---

## View User Details

```bash
id username
```

Example:

```bash
id tokyo
```

---

## View Group Information

```bash
cat /etc/group
```

---

# What I Learned

1. Difference between file owner and file group.
2. How to change ownership using `chown`.
3. How to change group ownership using `chgrp`.
4. How to change owner and group simultaneously using `chown owner:group`.
5. How recursive ownership changes work using the `-R` flag.
6. How ownership and permissions work together to control access.
7. How to verify ownership changes using `ls -l` and `ls -lR`.

---

# Outcome

Successfully created files, groups, and directory structures; changed file ownership and group ownership; applied recursive ownership changes; and gained practical experience with Linux ownership management using `chown` and `chgrp`.
