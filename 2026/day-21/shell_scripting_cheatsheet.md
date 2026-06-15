# Bash Scripting & Linux DevOps Cheat Sheet

## Quick Reference Table

| Topic       | Syntax                 | Example                  |
| ----------- | ---------------------- | ------------------------ |
| Variable    | VAR="value"            | NAME="Shubham"           |
| User Input  | read                   | read -p "Name:" name     |
| Arguments   | $1 $2 $# $@            | ./script.sh nginx docker |
| If          | if [ condition ]; then | if [ -f file ]; then     |
| Case        | case ... esac          | case "$x" in             |
| For Loop    | for i in list          | for i in 1 2 3           |
| While Loop  | while condition        | while [ $i -lt 5 ]       |
| Function    | name() { }             | greet() { echo Hi; }     |
| Grep        | grep pattern file      | grep -i error log        |
| Awk         | awk '{print $1}'       | awk -F: '{print $1}'     |
| Sed         | sed 's/a/b/g'          | sed -i 's/foo/bar/g'     |
| Debug       | set -x                 | Trace commands           |
| Strict Mode | set -euo pipefail      | Safe scripting           |

---

# 1. Basics

## Shebang

```bash
#!/bin/bash
```

Tells Linux to run the script using Bash.

---

## Running Scripts

Give execute permission:

```bash
chmod +x script.sh
```

Run:

```bash
./script.sh
```

or

```bash
bash script.sh
```

---

## Comments

Single line:

```bash
# This is a comment
```

Inline:

```bash
echo "Hello" # comment
```

---

## Variables

Declare:

```bash
NAME="Shubham"
```

Use:

```bash
echo $NAME
echo "$NAME"
```

Single quotes prevent expansion:

```bash
echo '$NAME'
```

Output:

```text
$NAME
```

---

## User Input

```bash
read -p "Enter Name: " name

echo "$name"
```

---

## Command Line Arguments

```bash
./script.sh nginx docker
```

| Variable | Meaning                    |
| -------- | -------------------------- |
| $0       | Script name                |
| $1       | First argument             |
| $2       | Second argument            |
| $#       | Number of arguments        |
| $@       | All arguments              |
| $?       | Previous command exit code |

Example:

```bash
echo "$1"
echo "$#"
```

---

# 2. Operators and Conditionals

## String Comparisons

Equal:

```bash
[ "$a" = "$b" ]
```

Not Equal:

```bash
[ "$a" != "$b" ]
```

Empty String:

```bash
[ -z "$var" ]
```

Not Empty:

```bash
[ -n "$var" ]
```

---

## Integer Comparisons

```bash
[ 5 -eq 5 ]
[ 5 -ne 4 ]
[ 5 -lt 10 ]
[ 10 -gt 5 ]
[ 5 -le 5 ]
[ 5 -ge 5 ]
```

---

## File Tests

File Exists:

```bash
[ -f file ]
```

Directory Exists:

```bash
[ -d dir ]
```

Exists:

```bash
[ -e path ]
```

Readable:

```bash
[ -r file ]
```

Writable:

```bash
[ -w file ]
```

Executable:

```bash
[ -x script.sh ]
```

Not Empty:

```bash
[ -s file ]
```

---

## If / Elif / Else

```bash
if [ "$a" -eq 1 ]; then
    echo "One"
elif [ "$a" -eq 2 ]; then
    echo "Two"
else
    echo "Other"
fi
```

---

## Logical Operators

AND:

```bash
[ -f file ] && echo "Exists"
```

OR:

```bash
[ -f file ] || echo "Missing"
```

NOT:

```bash
! command
```

Example:

```bash
if ! grep -q "error" app.log; then
    echo "No errors"
fi
```

---

# Understanding ! Operator

Normal:

```bash
grep -q error app.log
```

Exit codes:

```text
0 = Success
1 = Failure
```

Using NOT:

```bash
if ! grep -q error app.log; then
    echo "Error not found"
fi
```

Meaning:

```text
Execute block when command fails.
```

---

## Case Statement

Syntax:

```bash
case "$var" in
    pattern1)
        commands
        ;;
    pattern2)
        commands
        ;;
    *)
        default
        ;;
esac
```

Example:

```bash
read -p "Choice: " choice

case "$choice" in
    1)
        echo "Nginx"
        ;;
    2)
        echo "Docker"
        ;;
    3)
        echo "SSH"
        ;;
    *)
        echo "Invalid"
        ;;
esac
```

Multiple matches:

```bash
case "$ans" in
    y|Y|yes|YES)
        echo "Accepted"
        ;;
    n|N|no|NO)
        echo "Rejected"
        ;;
    *)
        echo "Invalid"
        ;;
esac
```

---

# 3. Loops

## For Loop

List Based:

```bash
for i in 1 2 3
do
    echo "$i"
done
```

C Style:

```bash
for ((i=1;i<=5;i++))
do
    echo "$i"
done
```

---

## While Loop

```bash
count=1

while [ "$count" -le 5 ]
do
    echo "$count"
    ((count++))
done
```

---

## Until Loop

```bash
count=1

until [ "$count" -gt 5 ]
do
    echo "$count"
    ((count++))
done
```

---

## Break

```bash
for i in 1 2 3 4
do
    [ "$i" -eq 3 ] && break
    echo "$i"
done
```

---

## Continue

```bash
for i in 1 2 3 4
do
    [ "$i" -eq 3 ] && continue
    echo "$i"
done
```

---

## Loop Through Files

```bash
for file in *.log
do
    echo "$file"
done
```

---

## Loop Through Command Output

```bash
cat users.txt | while read line
do
    echo "$line"
done
```

---

# 4. Functions

## Define Function

```bash
greet() {
    echo "Hello"
}
```

---

## Call Function

```bash
greet
```

---

## Parameters

```bash
greet() {
    echo "Hello $1"
}

greet Shubham
```

---

## Return vs Echo

Return status:

```bash
check() {
    return 0
}
```

Return value:

```bash
get_name() {
    echo "Shubham"
}

name=$(get_name)
```

---

## Local Variables

```bash
demo() {
    local name="Shubham"
    echo "$name"
}
```

---

# 5. Text Processing

## grep

```bash
grep error log.txt
grep -i error log.txt
grep -r error .
grep -n error log.txt
grep -c error log.txt
grep -v error log.txt
grep -E "error|warning"
```

---

## awk

Print first column:

```bash
awk '{print $1}' file
```

Delimiter:

```bash
awk -F: '{print $1}' /etc/passwd
```

Pattern:

```bash
awk '/error/ {print}'
```

BEGIN:

```bash
awk 'BEGIN {print "Start"}'
```

END:

```bash
awk 'END {print NR}'
```

---

## sed

Replace:

```bash
sed 's/old/new/'
```

Global:

```bash
sed 's/old/new/g'
```

Delete line:

```bash
sed '5d' file
```

In-place:

```bash
sed -i 's/foo/bar/g' file
```

---

## cut

```bash
cut -d: -f1 /etc/passwd
```

---

## sort

```bash
sort file
sort -n file
sort -r file
sort -u file
```

---

## uniq

```bash
uniq file
uniq -c file
```

---

## tr

```bash
echo hello | tr a-z A-Z
echo hello | tr -d l
```

---

## wc

```bash
wc -l file
wc -w file
wc -m file
```

---

## head / tail

```bash
head file
tail file
tail -50 file
tail -f app.log
```

---

# 6. Useful DevOps One-Liners

Delete files older than 30 days:

```bash
find /tmp -type f -mtime +30 -delete
```

Count lines in logs:

```bash
wc -l *.log
```

Replace string in configs:

```bash
sed -i 's/old/new/g' *.conf
```

Check service:

```bash
systemctl is-active nginx
```

Disk usage alert:

```bash
df -h | awk '$5+0 > 80'
```

Parse JSON:

```bash
jq '.name' file.json
```

Real-time errors:

```bash
tail -f app.log | grep --line-buffered ERROR
```

Find largest files:

```bash
du -ah / | sort -rh | head -20
```

Top CPU processes:

```bash
ps aux --sort=-%cpu | head
```

Top Memory processes:

```bash
ps aux --sort=-%mem | head
```

---

# 7. Error Handling & Debugging

## Exit Codes

Success:

```bash
exit 0
```

Failure:

```bash
exit 1
```

Check:

```bash
echo $?
```

---

## set -e

Exit immediately on error.

```bash
set -e
```

---

## set -u

Fail on unset variables.

```bash
set -u
```

---

## set -o pipefail

Pipeline fails if any command fails.

```bash
set -o pipefail
```

---

## set -x

Debug mode.

```bash
set -x
```

---

## Strict Mode

```bash
set -euo pipefail
```

Best practice for production scripts.

---

## Trap

Cleanup before exit.

```bash
cleanup() {
    rm -f temp.txt
}

trap cleanup EXIT
```

---

# DevOps Commands To Memorize

```bash
journalctl -u nginx -f
systemctl status nginx
systemctl is-active nginx
ps aux | grep nginx
ss -tulpn
netstat -tulpn
free -h
top
vmstat 1
iostat -x 1
df -h
du -sh *
find /var/log -name "*.log"
tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

# Interview Tips

1. Prefer `case` over long `if-elif` chains for menus.
2. Always quote variables: `"$var"`.
3. Use `set -euo pipefail` in production scripts.
4. Use functions to avoid duplicate code.
5. Validate user input before using it.
6. Use `local` variables inside functions.
7. Use `journalctl` for service troubleshooting and application logs for request troubleshooting.
