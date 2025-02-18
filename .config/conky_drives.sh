#!/bin/bash

# Function to get disk temperature
get_hddtemp() {
  # Check if smartctl exists
  if ! command -v /usr/sbin/smartctl &> /dev/null; then
    echo 'err'
  fi

  # Get device path (e.g., /dev/sda, /dev/nvme0)
  DEVICE=$1

  # Check if the device is a hard disk (sdX)
  if [[ $DEVICE =~ ^/dev/sd ]]; then
    # Get temperature for hard disk
    TEMP=$(sudo smartctl -A $DEVICE | grep 194 | sed 's/[[:space:]]\+/ /g' | cut -d' ' -f 10)
    if [ -z "$TEMP" ]; then
      echo 'err'
    else
      echo "${TEMP}°C"
    fi
  # Check if the device is an NVMe disk (nvmeX)
  elif [[ $DEVICE =~ ^/dev/nvme ]]; then
    # Get temperature for NVMe disk
    TEMP=$(sudo smartctl -A $DEVICE | grep "Temperature:" | sed 's/[[:space:]]\+/ /g' | cut -d' ' -f 2)
    if [ -z "$TEMP" ]; then
      echo 'err'
    else
      echo "${TEMP}°C"
    fi
  else
    echo 'err'
  fi
}

# Loop through all block devices except 'loop'
for dev in $(lsblk -d -n -o NAME | grep -v '^loop'); do
  # Get the temperature for the device
  TEMP_VAL=$(get_hddtemp /dev/$dev)
  
  # Generate the Conky configuration for each device
  echo "\${if_existing /dev/$dev}\${color3}/dev/$dev"
  echo "\${color1}Disk I/O:\${color2} \${diskio $dev}\${alignr}\${color1}\${if_existing /usr/sbin/smartctl}Temp:\${color2} ${TEMP_VAL}\${endif}"
  echo "\${color1}Read: \${color2}\${diskio_read $dev}\${alignr}\${color1}Write: \${color2}\${diskio_write}"
  echo "\${color4}\${diskiograph_read $dev 24,140 ffff00 ffff00}\${alignr}\${diskiograph_write $dev 24,140 ffff00 ffff00}\${endif}"
done
