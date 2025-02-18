#!/bin/bash

# Get list of network interfaces
for interface in $(ls /sys/class/net/); do
  # Exclude 'docker#', 'lo', and any interfaces containing 'bridge'
  if [[ "$interface" != lo && "$interface" != docker* && "$interface" != veth* && "$interface" != *bridge* && "$interface" != virbr* && 
      -d "/sys/class/net/$interface" && -f "/sys/class/net/$interface/address" ]]; then
    # Check if the interface is up, has a link, and address
    if [[ -f "/sys/class/net/$interface/operstate" && $(cat /sys/class/net/$interface/operstate) == "up" ]]; then
      # Output Conky config for the interface
      echo "\${if_up $interface}\${color}\${stippled_hr}"
      echo "\${color3}$interface:    \${color2}\${addr $interface}"
      echo "\${color1}Down: \${color2}\${downspeed $interface}\${alignr}\${color1}Up: \${color2}\${upspeed $interface}"
      echo "\${color4}\${downspeedgraph $interface 24,140 00aa00 00ffff}\${alignr}\${upspeedgraph $interface 24,140 ff8800 ff4400}"
      echo -n "\${endif}"
    else
      echo "\${if_up $interface}\${color}\${stippled_hr}"
      echo "\${color3}$interface:    \${color2}\${addr $interface}"
      echo -n "\${endif}"
    fi
  fi
done
