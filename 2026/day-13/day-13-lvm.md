# Complete LVM Workflow (My Lab Example)

## Scenario

Combined two EBS volumes:

```text
/dev/nvme2n1 = 15GB
/dev/nvme3n1 = 20GB
```

Created:

```text
Volume Group  : devops-vg
Logical Volume: app-data
Filesystem    : ext4
Mount Point   : /mnt/app-data
```

---

# Step 1: Verify Attached Disks

```bash
lsblk
```

Output:

```text
nvme2n1 15G
nvme3n1 20G
```

Purpose:

* Verify disks are attached to the server.

---

# Step 2: Enter LVM Shell

```bash
sudo lvm
```

Prompt:

```text
lvm>
```

Purpose:

* Interactive mode for LVM management.

---

# Step 3: Create Physical Volumes (PV)

Convert disks into LVM-managed disks.

```bash
lvm> pvcreate /dev/nvme2n1
lvm> pvcreate /dev/nvme3n1
```

Verify:

```bash
lvm> pvs
```

Example Output:

```text
PV           VG Fmt  Attr PSize
/dev/nvme2n1    lvm2 --- 15.00g
/dev/nvme3n1    lvm2 --- 20.00g
```

Purpose:

* Makes disks available to LVM.

---

# Step 4: Create Volume Group (VG)

Combine multiple disks into one storage pool.

```bash
lvm> vgcreate devops-vg /dev/nvme2n1 /dev/nvme3n1
```

Verify:

```bash
lvm> vgs
```

Example Output:

```text
VG         #PV #LV VSize
devops-vg    2   0 35.00g
```

Purpose:

* Creates a 35GB storage pool.

---

# Step 5: Create Logical Volume (LV)

Create usable storage from the Volume Group.

```bash
lvm> lvcreate -L 28G -n app-data devops-vg
```

Meaning:

| Option        | Purpose        |
| ------------- | -------------- |
| `-L 28G`      | Create 28GB LV |
| `-n app-data` | LV name        |
| `devops-vg`   | Volume Group   |

Verify:

```bash
lvm> lvs
```

Output:

```text
LV       VG
app-data devops-vg
```

---

# Step 6: Verify LVM Layout

```bash
lvm> pvs
lvm> vgs
lvm> lvs
```

Expected:

```text
PVs = 2
VGs = 1
LVs = 1
```

Exit LVM shell:

```bash
lvm> exit
```

---

# Step 7: Create Filesystem

A Logical Volume is raw storage until a filesystem is created.

```bash
sudo mkfs -t ext4 /dev/devops-vg/app-data
```

Meaning:

| Option    | Purpose             |
| --------- | ------------------- |
| `mkfs`    | Make filesystem     |
| `-t ext4` | Use ext4 filesystem |

Verify:

```bash
sudo file -s /dev/devops-vg/app-data
```

Output:

```text
Linux rev 1.0 ext4 filesystem data
```

---

# Step 8: Create Mount Point

```bash
sudo mkdir /mnt/app-data
```

Purpose:

* Directory where storage will be accessible.

---

# Step 9: Mount Logical Volume

```bash
sudo mount /dev/devops-vg/app-data /mnt/app-data
```

Verify:

```bash
df -h
```

My Output:

```text
/dev/mapper/devops--vg-app--data 28G ... /mnt/app-data
```

Also verify:

```bash
lsblk
```

Output:

```text
nvme2n1
 └─devops--vg-app--data

nvme3n1
 └─devops--vg-app--data
```

Purpose:

* Makes storage available to users.

---

# Step 10: Test Storage

```bash
cd /mnt/app-data

touch test.txt

ls -l
```

Purpose:

* Verify read/write access.

---

# Step 11: Extend Logical Volume

Increase storage without creating a new partition.

```bash
sudo lvextend -L +2GB /dev/devops-vg/app-data
```

Output:

```text
Size of logical volume devops-vg/app-data changed
from 28.00 GiB to 30.00 GiB
```

Verify:

```bash
lsblk
```

Output:

```text
devops--vg-app--data 30G
```

---

# Step 12: Grow Filesystem

After extending LV, filesystem must also be expanded.

For ext4:

```bash
sudo resize2fs /dev/devops-vg/app-data
```

Verify:

```bash
df -h
```

Output should now show:

```text
30G mounted at /mnt/app-data
```

Purpose:

* Makes newly allocated storage usable.

---

# Step 13: Unmount Filesystem

Before deleting storage:

```bash
sudo umount /mnt/app-data
```

Verify:

```bash
df -h
```

Mount point disappears.

---

# Step 14: Enter LVM Shell Again

```bash
sudo lvm
```

---

# Step 15: Remove Logical Volume

```bash
lvm> lvremove /dev/devops-vg/app-data
```

Output:

```text
Logical volume "app-data" successfully removed
```

Purpose:

* Deletes virtual partition.

---

# Step 16: Remove Volume Group

```bash
lvm> vgremove devops-vg
```

Output:

```text
Volume group "devops-vg" successfully removed
```

Purpose:

* Deletes storage pool.

---

# Step 17: Verify Cleanup

```bash
lvm> pvs
```

My Output:

```text
PV           VG Fmt Attr PSize PFree
/dev/nvme2n1    lvm2 --- 15G 15G
/dev/nvme3n1    lvm2 --- 20G 20G
```

Meaning:

* Physical volumes remain.
* Volume group removed.
* Space is free.

Verify:

```bash
lvm> lvs
```

Output:

```text
No logical volumes
```

Exit:

```bash
lvm> exit
```

---

# Complete Command Flow

```bash
# Enter LVM
sudo lvm

# Create Physical Volumes
pvcreate /dev/nvme2n1
pvcreate /dev/nvme3n1

# Create Volume Group
vgcreate devops-vg /dev/nvme2n1 /dev/nvme3n1

# Create Logical Volume
lvcreate -L 28G -n app-data devops-vg

# Verify
pvs
vgs
lvs

# Exit
exit

# Create Filesystem
sudo mkfs -t ext4 /dev/devops-vg/app-data

# Create Mount Point
sudo mkdir /mnt/app-data

# Mount
sudo mount /dev/devops-vg/app-data /mnt/app-data

# Verify
df -h
lsblk

# Extend LV
sudo lvextend -L +2G /dev/devops-vg/app-data

# Grow Filesystem
sudo resize2fs /dev/devops-vg/app-data

# Unmount
sudo umount /mnt/app-data

# Enter LVM
sudo lvm

# Cleanup
lvremove /dev/devops-vg/app-data
vgremove devops-vg

# Verify
pvs
lvs

# Exit
exit
```

## Quick Memory Trick

```text
Disk → PV → VG → LV → Filesystem → Mount

PV = Physical Volume
VG = Volume Group
LV = Logical Volume
```
---



# Important LVM Commands Cheat Sheet



| Command  | Purpose                | Example                                        |

| -------- | ---------------------- | ---------------------------------------------- |

| pvs      | Show Physical Volumes  | `pvs`                                          |

| vgs      | Show Volume Groups     | `vgs`                                          |

| lvs      | Show Logical Volumes   | `lvs`                                          |

| pvcreate | Create Physical Volume | `pvcreate /dev/nvme2n1`                        |

| vgcreate | Create Volume Group    | `vgcreate devops-vg /dev/nvme2n1 /dev/nvme3n1` |

| lvcreate | Create Logical Volume  | `lvcreate -L 28G -n app-data devops-vg`        |

| lvextend | Extend Logical Volume  | `lvextend -L +2G /dev/devops-vg/app-data`      |

| lvremove | Remove Logical Volume  | `lvremove /dev/devops-vg/app-data`             |

| vgremove | Remove Volume Group    | `vgremove devops-vg`                           |

| pvremove | Remove LVM metadata    | `pvremove /dev/nvme2n1`                        |

| exit     | Exit LVM shell         | `exit`                                         |



---



# What I Learned



1. Multiple disks can be combined into a single Volume Group (VG).

2. Logical Volumes (LV) provide flexible storage that can be extended later.

3. Filesystems must be created before mounting.

4. `df -h` verifies mounted filesystems, while `lsblk` shows storage structure.

5. LVM storage can be resized without creating new partitions.

6. Storage should be unmounted before deleting logical volumes.

7. `pvs`, `vgs`, and `lvs` are the primary troubleshooting commands for LVM.
