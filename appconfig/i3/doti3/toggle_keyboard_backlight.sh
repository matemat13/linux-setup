#!/bin/bash

KB_BL_PATH="/sys/devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00"
CURRENT_MODE=$(cat "$KB_BL_PATH/kbd_backlight_mode")

# turn the backlight on (mode 16 is off)
if [ "$CURRENT_MODE" = "16" ]; then

  echo 8 > "$KB_BL_PATH/kbd_backlight_mode"

# else turn it off
else

  echo 16 > "$KB_BL_PATH/kbd_backlight_mode"

fi

CURRENT_MODE=$(cat "$KB_BL_PATH/kbd_backlight_mode")
if [ "$CURRENT_MODE" = "16" ]; then

  notify-send -u low -i mouse "Keyboard backlight off"

else

  notify-send -u low -i mouse "Keyboard backlight on"

fi
