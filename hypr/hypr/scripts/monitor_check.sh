#!/bin/bash

# Configuration
HDMI_PORT="HDMI-A-1"       # Replace with the actual name from 'hyprctl monitors'
LAPTOP_SCREEN="eDP-1"      # Replace with the actual name from 'hyprctl monitors'
CHECK_INTERVAL=5           # Check every 5 seconds
CONFIG_FILE=~/.config/hypr/hyprland.conf # Omarchy's main config file

# Variables to track the previous state
HDMI_WAS_CONNECTED=false

while true; do
    # Check if the HDMI port name appears in the 'hyprctl monitors' output
    if hyprctl monitors | grep -q "$HDMI_PORT"; then
        
        # HDMI is connected.
        if ! $HDMI_WAS_CONNECTED; then
            echo "HDMI ($HDMI_PORT) connected. Applying HDMI-only config."
            
            # Use 'hyprctl keyword' to dynamically change the monitor configuration
            # This command disables the laptop screen and enables the HDMI screen.
            # 'preferred' is often used to ensure the HDMI is at its optimal resolution.
            hyprctl keyword monitor "$LAPTOP_SCREEN, disable"
            hyprctl keyword monitor "$HDMI_PORT, preferred, auto, 1"

            HDMI_WAS_CONNECTED=true
        fi

    else
        
        # HDMI is disconnected.
        if $HDMI_WAS_CONNECTED; then
            echo "HDMI ($HDMI_PORT) disconnected. Re-enabling internal screen ($LAPTOP_SCREEN)."
            
            # Enable the laptop screen and disable the HDMI port
            hyprctl keyword monitor "$LAPTOP_SCREEN, preferred, auto, 1"
            hyprctl keyword monitor "$HDMI_PORT, disable" 

            HDMI_WAS_CONNECTED=false
        fi
        
    fi

    sleep "$CHECK_INTERVAL"
done
