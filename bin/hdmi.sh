#!/usr/bin/env bash

# Use 'xrandr' to find these
VGA="VGA-0"
HDMI="HDMI-0"
INTERNAL_DISPLAY="LVDS"

VGA_FILE="/sys/class/drm/card0-VGA-1/status"
HDMI_FILE="/sys/class/drm/card0-HDMI-A-1/status"

# Check /sys/class/drm for the exact location
if [[ -e $VGA_FILE ]]; then VGA_STATUS="$(cat $VGA_FILE)"; fi
if [[ -e $HDMI_FILE ]]; then HDMI_STATUS="$(cat $HDMI_FILE)"; fi

# Do no change!
EXTERNAL_DISPLAY=""

# Check to see if the external display is connected
if [[ "${VGA_STATUS}" = "connected" ]]; then EXTERNAL_DISPLAY=$VGA; fi
if [[ "${HDMI_STATUS}" = "connected" ]]; then EXTERNAL_DISPLAY=$HDMI; fi

# The external display is connected
if [[ "$EXTERNAL_DISPLAY" != "" ]]; then
    xrandr --output $INTERNAL_DISPLAY --auto
    xrandr --output $EXTERNAL_DISPLAY --auto
    xrandr --output $INTERNAL_DISPLAY --left-of $EXTERNAL_DISPLAY

    # The external display is not connected
else
    # Restore to single display
    xrandr --auto
fi
exit 0
