#!/bin/bash
# author: Tomas Baca
# update: Matous Vrba

INCREMENT=10 # in percent
MINIMAL=2

# modified to work without xbacklight
MAX_BRIGHTNESS=$(cat /sys/class/backlight/*/max_brightness)
CURRENT_BRIGHTNESS=$(( $(cat /sys/class/backlight/*/actual_brightness)*100/$MAX_BRIGHTNESS ))

if [ $# -eq 0 ]; then

  echo "Current brightness is: $CURRENT_BRIGHTNESS%"

else

  # increase brightness
  if [ "$1" = "+" ]; then

    if [[ $(( $CURRENT_BRIGHTNESS + $INCREMENT )) -gt 100 ]]; then

      echo $MAX_BRIGHTNESS > /sys/class/backlight/*/brightness

    else

      echo $(( ($CURRENT_BRIGHTNESS+$INCREMENT)*$MAX_BRIGHTNESS/100 )) > /sys/class/backlight/*/brightness

    fi

  # decrease brightness
  elif [ "$1" = "-" ]; then

    if [[ $(( $CURRENT_BRIGHTNESS - $INCREMENT )) -lt $MINIMAL ]]; then

      echo $(( $MINIMAL*$MAX_BRIGHTNESS/100 )) > /sys/class/backlight/*/brightness

    else

      echo $(( ($CURRENT_BRIGHTNESS-$INCREMENT)*$MAX_BRIGHTNESS/100 )) > /sys/class/backlight/*/brightness

    fi

  # set the user-specified brightness
  else

    echo $(( $1*$MAX_BRIGHTNESS/100 )) > /sys/class/backlight/*/brightness

  fi

fi

CURRENT_BRIGHTNESS=$(( $(cat /sys/class/backlight/*/actual_brightness)*100/$MAX_BRIGHTNESS ))
if [ $CURRENT_BRIGHTNESS -ge 100 ]; then

  notify-send -u low -i mouse "Brightness on MAX"

elif [ $CURRENT_BRIGHTNESS -le $MINIMAL ]; then

  notify-send -u low -i mouse "Brightness on MIN"

fi
