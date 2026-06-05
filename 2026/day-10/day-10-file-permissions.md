# Day 10 - File Permissions & File Operations Challenge

## Objective

Learn how to create, read, modify, and manage files in Linux while understanding file permissions and access control.

---

# Task 1: Create Files

## Create Empty File

```bash
touch devops.txt
```

Verify:

```bash
ls -l devops.txt
```

---

## Create notes.txt with Content

Using echo:

```bash
echo "Day 10 - File Permissions Challenge" > notes.txt
echo "Learning Linux permissions." >> notes.txt
```

Alternative using cat:

```bash
cat > notes.txt
```

Type content and press:

```text
Ctrl + D
```

to save.

Verify:

```bash
cat notes.txt
```

---

## Create script.sh

Using vim:

```bash
vim script.sh
```

Press:

```text
i
```

Insert mode:

```bash
echo "Hello DevOps"
```

Save and exit:

```text
Esc
:wq
```

Verify:

```bash
cat script.sh
```

---

## Check Default Permissions

```bash
ls -l
```

Example:

```text
-rw-rw-r-- 1 ubuntu ubuntu 0 devops.txt
-rw-rw-r-- 1 ubuntu ubuntu 50 notes.txt
-rw-rw-r-- 1 ubuntu ubuntu 19 script.sh
```

---

# Task 2: Read Files

## Read notes.txt

```bash
cat notes.txt
```

---

## Open script.sh in Read-Only Mode

```bash
vim -R script.sh
```

or

```bash
view script.sh
```

---

## Display First 5 Lines of /etc/passwd

```bash
head -n 5 /etc/passwd
```

---

## Display Last 5 Lines of /etc/passwd

```bash
tail -n 5 /etc/passwd
```

---

# Task 3: Understand Permissions

Permission Format:

```text
rwxrwxrwx
│  │  │
│  │  └── Others
│  └───── Group
└──────── Owner
```

Values:

| Permission  | Value |
| ----------- | ----- |
| Read (r)    | 4     |
| Write (w)   | 2     |
| Execute (x) | 1     |

Examples:

| Permission | Value |
| ---------- | ----- |
| rwx        | 7     |
| rw-        | 6     |
| r-x        | 5     |
| r--        | 4     |
| ---        | 0     |

---

## Check Current Permissions

```bash
ls -l devops.txt notes.txt script.sh
```

Example:

```text
-rw-rw-r-- devops.txt
-rw-rw-r-- notes.txt
-rw-rw-r-- script.sh
```

Meaning:

### Owner

```text
rw-
```

Can:

* Read
* Write

Cannot:

* Execute

### Group

```text
rw-
```

Can:

* Read
* Write

Cannot:

* Execute

### Others

```text
r--
```

Can:

* Read

Cannot:

* Write
* Execute

---

# Task 4: Modify Permissions

## Make script.sh Executable

```bash
chmod +x script.sh
```

Verify:

```bash
ls -l script.sh
```

Output:

```text
-rwxrwxr-x
```

Run script:

```bash
./script.sh
```

Output:

```text
Hello DevOps
```

---

## Make devops.txt Read-Only

Remove write permission:

```bash
chmod a-w devops.txt
```

Verify:

```bash
ls -l devops.txt
```

Output:

```text
-r--r--r--
```

---

## Set notes.txt to 640

```bash
chmod 640 notes.txt
```

Verify:

```bash
ls -l notes.txt
```

Output:

```text
-rw-r-----
```

Explanation:

```text
Owner = rw-
Group = r--
Others = ---
```

---

## Create Project Directory

```bash
mkdir project
```

Set permissions:

```bash
chmod 755 project
```

Verify:

```bash
ls -ld project
```

Output:

```text
drwxr-xr-x
```

Explanation:

```text
Owner = rwx
Group = r-x
Others = r-x
```

---

# Task 5: Test Permissions

## Try Writing to Read-Only File

```bash
echo "Testing" >> devops.txt
```

Expected:

If you removed your own write permission:

```text
Permission denied
```

or the shell refuses modification depending on ownership and permissions.

---

## Remove Execute Permission from Script

```bash
chmod -x script.sh
```

Verify:

```bash
ls -l script.sh
```

Output:

```text
-rw-r--r--
```

Try executing:

```bash
./script.sh
```

Expected:

```text
bash: ./script.sh: Permission denied
```

Reason:

The execute bit is not set.

---

# Commands Used

## File Creation

```bash
touch
echo
cat
vim
mkdir
```

## File Reading

```bash
cat
head
tail
view
```

## Permission Management

```bash
chmod
ls -l
ls -ld
```

## File Execution

```bash
./script.sh
```

---

# Command Flags Learned

## chmod

| Command        | Meaning                   |
| -------------- | ------------------------- |
| chmod +x file  | Add execute permission    |
| chmod -x file  | Remove execute permission |
| chmod +w file  | Add write permission      |
| chmod -w file  | Remove write permission   |
| chmod a-w file | Remove write for all      |
| chmod 755 dir  | rwxr-xr-x                 |
| chmod 775 dir  | rwxrwxr-x                 |
| chmod 640 file | rw-r-----                 |

---

## head

| Flag | Meaning            |
| ---- | ------------------ |
| -n 5 | Show first 5 lines |

Example:

```bash
head -n 5 /etc/passwd
```

---

## tail

| Flag | Meaning           |
| ---- | ----------------- |
| -n 5 | Show last 5 lines |

Example:

```bash
tail -n 5 /etc/passwd
```

---

## vim

| Option      | Meaning        |
| ----------- | -------------- |
| vim file    | Edit file      |
| vim -R file | Read-only mode |
| view file   | Read-only mode |

---

# Permission Cheat Sheet

| Number | Permission |
| ------ | ---------- |
| 7      | rwx        |
| 6      | rw-        |
| 5      | r-x        |
| 4      | r--        |
| 3      | -wx        |
| 2      | -w-        |
| 1      | --x        |
| 0      | ---        |

Examples:

```text
755 = rwxr-xr-x
775 = rwxrwxr-x
644 = rw-r--r--
640 = rw-r-----
600 = rw-------
```

---

# What I Learned

1. How to create files using touch, cat, echo, and vim.
2. How to read files using cat, head, tail, and vim read-only mode.
3. How Linux permissions are represented using rwx notation.
4. How permission values are calculated using 4, 2, and 1.
5. How to make scripts executable using chmod +x.
6. Difference between file permissions and directory permissions.
7. Common permission errors such as "Permission denied" and how to troubleshoot them.

---

# Outcome

Successfully created files, modified permissions, executed scripts, tested permission restrictions, and gained hands-on experience with Linux file operations and access control.
