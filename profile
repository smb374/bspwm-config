#!/bin/bash

# General stuff in xprofile.

run() {
    if ! pgrep -f "$1"; then
        "${@}" &
    fi
}

run sxhkd -c "$BSPWM_ROOT/sxhkdrc"

feh --bg-fill "/home/poyehchen/Pictures/Wallpapers/104200866_p0.png"

eww -c "$EWW_ROOT" reload
eww -c "$EWW_ROOT" open bar

run "$SCRIPT_ROOT/workspace"

run "$SCRIPT_ROOT/volume"

run polybar -c "$BSPWM_ROOT/polybar.ini"
polybar-msg cmd restart
polybar-msg cmd hide

## Update Initial EWW variables
eww -c "$EWW_ROOT" update current-brightness="$(light -G)"
