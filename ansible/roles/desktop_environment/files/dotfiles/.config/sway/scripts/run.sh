#!/usr/bin/env bash

# Tofi
TOFI_RUN=/usr/bin/tofi-drun
TOFI_OPT="-c $HOME/.config/tofi/config --drun-launch=true"

# Wofi
WOFI_RUN=/usr/bin/wofi
WOFI_OPT="--show drun"

# Select runner
case "$1" in
  -t) runner=$TOFI_RUN;;
  -w) runner=$WOFI_RUN;;
esac

# Kill old runner processes
for pid in $(pidof $runner); do
  kill -9 $pid
done

# Make runner string
case $runner in
  $TOFI_RUN) runner_string="${runner} ${TOFI_OPT}";;
  $WOFI_RUN) runner_string="${runner} ${WOFI_OPT}";;
esac

# Execution runner string
eval $runner_string
