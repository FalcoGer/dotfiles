#!/bin/bash

# Check if rocm-smi exists
if ! command -v rocm-smi &> /dev/null; then
    exit 0
fi

# Validate input argument
if [[ -z "$2" ]]; then
    echo \$hr
    echo \${font :bold:size=10}GPU:\${font}
    rocm-smi | grep -E "^[0-9]" | sed 's/\([0-9]\+\).*/\1/g' | while read -r gpuid; do
        echo \${stippled_hr}
        echo \${color3}GPU "${gpuid}"
        echo \${color1}Freq:\$alignc\${color3}SCLK:\${color2}\${execp ~/.config/conky_rocm.sh " ${gpuid}"  SCLK} MHz  \${color3}MCLK:\${color2}\${execp ~/.config/conky_rocm.sh " ${gpuid}"  MCLK} MHz\$alignr\${color1}Temp:\${color2} \${execp ~/.config/conky_rocm.sh " ${gpuid}"  Temperature}°C
        echo \${color1}Usage:\${color2} \${execp ~/.config/conky_rocm.sh " ${gpuid}"  GPU}% \${color4}\${execgauge ~/.config/conky_rocm.sh " ${gpuid}"  GPU 24,48}\$alignr\${color1}VRAM:\${color2} \${execp ~/.config/conky_rocm.sh " ${gpuid}"  VRAM}% \${color4}\${execgauge ~/.config/conky_rocm.sh " ${gpuid}"  VRAM 24,48}
        echo \${color1}Power:\${color2} \${execp ~/.config/conky_rocm.sh " ${gpuid}"  Power}W\${color1}/\${color2}\${execp ~/.config/conky_rocm.sh " ${gpuid}"  PwrCap}W \${color1}\(\${color2}\${execp ~/.config/conky_rocm.sh 0 PowerPerc}%\${color1}\)\${color1}\$alignr\${execbar 8,140 ~/.config/conky_rocm.sh " ${gpuid}"  PowerPerc}
    done
    exit
fi

# Convert human-readable field name to the corresponding field index
case "$2" in
    "GPU") FIELD=16 ;;
    "Temperature") FIELD=5 ;;
    "Power") FIELD=6 ;;
    "SCLK") FIELD=10 ;;
    "MCLK") FIELD=11 ;;
    "Fan") FIELD=12 ;;
    "PwrCap") FIELD=14 ;;
    "VRAM") FIELD=15 ;;
    "PowerPerc") FIELD=-1 ;;
    *) 
        echo "Invalid field: $1"
        exit 1
        ;;
esac

# Run rocm-smi and process the output
rocm-smi | grep -E "^$1" | sed 's/[[:space:]]\+/ /g' | sed -E 's/°C|W|Mhz|%//g' | while read -r line; do
    if [ ${FIELD} -eq -1 ]; then
        Power=$(echo "${line}" | cut -d' ' -f 6 | cut -d'.' -f 1)
        PowerCap=$(echo "${line}" | cut -d' ' -f 14 | cut -d'.' -f 1)
        VALUE=$((${Power} * 100 / ${PowerCap}))
        if [ ${VALUE} -gt 100 ]; then
            VALUE=100
        fi
    else
        VALUE=$(echo "${line}" | cut -d' ' -f${FIELD} | cut -d'.' -f 1)
    fi
    echo "${VALUE}"
done
