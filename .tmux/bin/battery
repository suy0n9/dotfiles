#!/bin/bash

PERSENTAGE=$(/usr/bin/pmset -g ps | grep -o '[0-9]\+%' | tr -d '%')

# is_charging returns true if the battery is charging
is_charging() {
  _discharging=$(/usr/bin/pmset -g ps | grep 'discharging')

  if ! $_discharging; then
    return 1
  else
    return 0
  fi
}

if is_charging; then
  echo "#[fg=green] $PERSENTAGE% #[default]"
else
  # current battery <= 20
  if [ "$PERSENTAGE" -le 20 ]; then
    echo "#[fg=red] $PERSENTAGE% #[default]"
  else
    echo "#[fg=white] $PERSENTAGE% #[default]"
  fi
fi
