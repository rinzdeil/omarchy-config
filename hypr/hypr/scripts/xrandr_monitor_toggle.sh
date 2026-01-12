#!/usr/bin/env bash

# Names — change these if yours are different
HDMI_NAME="HDMI-A-1"         # External monitor name
EDP_NAME="eDP-1"             # Internal laptop screen

while true; do
  # Get monitor info in JSON
  monitors_json=$(hyprctl -j monitors)
  
  # Check if HDMI is present and active
  # Uses grep + jq-like logic, but we can parse via bash
  # You need `jq` for a more robust approach
  if echo "$monitors_json" | grep "\"name\": \"$HDMI_NAME\"" >/dev/null; then
    # Optionally check if disabled or not
    # For simplicity: assume if it's listed, it's connected
    echo "HDMI ($HDMI_NAME) detected --> disabling $EDP_NAME"
    hyprctl keyword "monitor $EDP_NAME, disable"
  else
    echo "No HDMI ($HDMI_NAME) detected --> enabling $EDP_NAME"
    # Here you might need the original mode, position, scale, etc.
    # E.g.: 1920x1080@60, 0x0, 1 — change to match your config
    hyprctl keyword "monitor $EDP_NAME, preferred, auto, 1"
  fi

  sleep 30
done

