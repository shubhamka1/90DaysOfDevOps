# file-io-practice.md

## Objective

Practice basic Linux file creation, writing, appending, and reading using standard commands.

### Create File

```bash
touch notes.txt
```

Creates an empty file named `notes.txt`.

### Write First Line

```bash
echo "Line 1 - Linux File I/O Practice" > notes.txt
```

Writes text to the file. `>` overwrites existing content.

### Append More Lines

```bash
echo "Line 2 - Learning redirection operators" >> notes.txt
echo "Line 3 - Practicing file operations" >> notes.txt
```

Appends text to the file. `>>` adds content without deleting existing data.

### Use tee to Write and Display

```bash
echo "Line 4 - Added using tee command" | tee -a notes.txt
```

Displays text on screen and appends it to the file simultaneously.

### Add Additional Lines

```bash
echo "Line 5 - Logs are text files" >> notes.txt
echo "Line 6 - Configurations are text files" >> notes.txt
echo "Line 7 - Scripts are text files" >> notes.txt
echo "Line 8 - File I/O is essential in DevOps" >> notes.txt
```

Adds more content to the file.

### Read Entire File

```bash
cat notes.txt
```

Displays the complete contents of the file.

**Observation:** Verified all lines were written successfully.

### Read First Two Lines

```bash
head -n 2 notes.txt
```

Displays the first two lines of the file.

**Observation:** Confirmed the beginning of the file contains the expected content.

### Read Last Two Lines

```bash
tail -n 2 notes.txt
```

Displays the last two lines of the file.

**Observation:** Confirmed the most recently appended lines were written correctly.

---

## Final File Content

```text
Line 1 - Linux File I/O Practice
Line 2 - Learning redirection operators
Line 3 - Practicing file operations
Line 4 - Added using tee command
Line 5 - Logs are text files
Line 6 - Configurations are text files
Line 7 - Scripts are text files
Line 8 - File I/O is essential in DevOps
```

---

## Additional Practice Commands

```bash
wc -l notes.txt
```

Counts the total number of lines in the file.

```bash
nl notes.txt
```

Displays the file with line numbers.

```bash
cp notes.txt notes_backup.txt
```

Creates a backup copy of the file.

```bash
mv notes_backup.txt notes_old.txt
```

Renames the backup file.

```bash
rm notes_old.txt
```

Deletes the renamed file.

---

## Key Learning

* `touch` creates a file.
* `>` writes and overwrites file content.
* `>>` appends content to a file.
* `cat` displays the entire file.
* `head` displays the beginning of a file.
* `tail` displays the end of a file.
* `tee` writes to a file and displays output simultaneously.
* `wc -l` counts lines in a file.
* `nl` adds line numbers while displaying content.
* `cp` copies files.
* `mv` renames or moves files.
* `rm` removes files.

## Why This Matters for DevOps

Most Linux administration tasks involve text files such as logs, configuration files, scripts, and data files. Understanding how to create, modify, read, and manage files is a fundamental skill for troubleshooting, automation, and production support.
