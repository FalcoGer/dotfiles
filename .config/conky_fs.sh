#!/bin/bash

# Declare an array to store mount points
mount_points=()

# Find the longest mount point name
max_len=0

# Read from /proc/mounts, update mount_points array, and update max_len 
while read -r device mount fs_type rest; do
    if [[ "$fs_type" =~ ^(ext2|ext3|ext4|btrfs|xfs|fat32|fat16|exfat|vfat|ntfs)$ ]] && [[ "$mount" != */snap/* ]]; then
        mount_points+=("$mount")
        (( ${#mount} > max_len )) && max_len=${#mount}
    fi
done < /proc/mounts

# Print the formatted output
for mount in "${mount_points[@]}"; do
    printf "\${color1}%-${max_len}s  \${color2}\${fs_used %s}/\${fs_size %s} \$alignr\${fs_used_perc %s}%% \${color}\${fs_bar 8,100 %s}\n" \
        "$mount" "$mount" "$mount" "$mount" "$mount"
done
