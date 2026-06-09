# Linux Cheat Sheet – FIND, AWK & SED

## 1. FIND COMMAND

### Purpose

Used to search files and directories.

### Syntax

```bash
find [path] [options] [expression]
```

### Common Commands

```bash
find . -name "file.txt"
```

Find file by exact name.

```bash
find . -iname "file.txt"
```

Case-insensitive search.

```bash
find . -type f
```

Find files only.

```bash
find . -type d
```

Find directories only.

```bash
find . -name "*.log"
```

Find all log files.

```bash
find . -size +100M
```

Find files larger than 100 MB.

```bash
find . -size -100M
```

Find files smaller than 100 MB.

```bash
find . -mtime -1
```

Modified in last 24 hours.

```bash
find . -mtime +7
```

Older than 7 days.

```bash
find . -empty
```

Find empty files/directories.

```bash
find . -user oracle
```

Find files owned by oracle.

```bash
find . -perm 777
```

Find files with permission 777.

### Execute Command on Found Files

```bash
find . -name "*.log" -exec gzip {} \;
```

### Delete Files

```bash
find . -name "*.tmp" -delete
```

### Delete Files Older Than 30 Days

```bash
find /backup -mtime +30 -delete
```

---

## 2. AWK COMMAND

### Purpose

Used for column extraction, filtering, reporting, and calculations.

### Syntax

```bash
awk 'condition { action }' file
```

### Important Variables

| Variable | Meaning            |
| -------- | ------------------ |
| $0       | Entire line        |
| $1       | First column       |
| $2       | Second column      |
| $NF      | Last column        |
| NR       | Record/Line Number |
| NF       | Number of Fields   |

### Sample Data

```text
101 John IT 50000
102 Mike HR 60000
103 David Finance 70000
104 Sarah IT 80000
```

### Column Operations

```bash
awk '{print $0}'
```

Print entire line.

```bash
awk '{print $1}'
```

Print first column.

```bash
awk '{print $1,$3}'
```

Print multiple columns.

```bash
awk '{print $NF}'
```

Print last column.

### Record Operations

```bash
awk '{print NR,$0}'
```

Print line number with data.

```bash
awk 'END{print NR}'
```

Count records.

```bash
awk '{print NF}'
```

Count fields.

### Filtering

```bash
awk '/ERROR/'
```

Find lines containing ERROR.

```bash
awk '$3=="FAILED"'
```

Find exact match.

```bash
awk '$4>50000'
```

Numeric comparison.

```bash
awk '$3=="IT" && $4>60000'
```

Multiple conditions.

### Calculations

```bash
awk '{sum+=$4} END{print sum}'
```

Sum a column.

```bash
awk '{sum+=$4} END{print sum/NR}'
```

Average.

```bash
awk 'max<$4 {max=$4} END{print max}'
```

Maximum value.

```bash
awk 'NR==1{min=$4} $4<min {min=$4} END{print min}'
```

Minimum value.

### Delimiters

CSV:

```bash
awk -F',' '{print $2}'
```

Pipe Delimited:

```bash
awk -F'|' '{print $2}'
```

### Line Selection

```bash
awk 'NR==1'
```

First line.

```bash
awk 'END{print}'
```

Last line.

```bash
awk 'NR>1'
```

Skip header.

```bash
awk 'NR%2==0'
```

Even lines.

```bash
awk 'NR%2==1'
```

Odd lines.

### Text Replacement

```bash
awk '{gsub("IT","Technology"); print}'
```

---

## 3. SED COMMAND

### Purpose

Used to search, replace, insert, delete and modify text.

### Syntax

```bash
sed 'operation' file
```

### Search and Replace

```bash
sed 's/old/new/'
```

Replace first occurrence.

```bash
sed 's/old/new/g'
```

Replace all occurrences.

```bash
sed -i 's/old/new/g' file.txt
```

Modify file directly.

### Print Lines

```bash
sed -n '5p' file.txt
```

Print line 5.

```bash
sed -n '5,10p' file.txt
```

Print range.

```bash
sed -n '$p' file.txt
```

Print last line.

### Delete Lines

```bash
sed '5d'
```

Delete line 5.

```bash
sed '5,10d'
```

Delete range.

```bash
sed '/^$/d'
```

Delete blank lines.

```bash
sed '/ERROR/d'
```

Delete matching lines.

### Insert / Append

```bash
sed '3i\New Line'
```

Insert before line 3.

```bash
sed '3a\New Line'
```

Append after line 3.

```bash
sed '3c\Updated Line'
```

Replace line 3.

### Pattern Matching

```bash
sed -n '/ERROR/p'
```

Print matching lines.

```bash
sed 's/ERROR/SUCCESS/g'
```

Replace text.

---

# Production Support Examples

### Count Records

```bash
awk 'END{print NR}' interface.dat
```

### Display Header

```bash
awk 'NR==1' interface.dat
```

### Display Trailer

```bash
awk 'END{print}' interface.dat
```

### Sum Transaction Amount

```bash
awk -F'|' '{sum+=$5} END{print sum}' transaction.dat
```

### Display Failed Records

```bash
awk -F'|' '$3=="FAILED"' batch.dat
```

### Find Today's Files

```bash
find /data/inbound -mtime -1
```

### Find COB Date Files

```bash
find /data/inbound -name "*20260609*"
```

### Replace COB Date

```bash
sed 's/20260608/20260609/g' runbook.txt
```

### Remove Blank Records

```bash
sed '/^$/d' interface.dat
```

---

# Useful One-Liners

```bash
# FIND
find . -name "*.log"
find . -type f
find . -mtime -1
find . -size +100M

# AWK
awk '{print $1}' file
awk '{print $NF}' file
awk 'END{print NR}' file
awk -F'|' '{print $2}' file
awk '$3=="FAILED"' file
awk '{sum+=$4} END{print sum}' file

# SED
sed 's/old/new/g' file
sed -i 's/old/new/g' file
sed '5d' file
sed -n '5p' file
sed '/^$/d' file
sed -n '$p' file
```

---

# Memory Trick

* FIND = Search files/directories
* AWK = Process columns/data
* SED = Edit text streams

find → Search
awk → Analyze data
sed → Modify text
