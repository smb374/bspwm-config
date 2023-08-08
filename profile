#!/bin/bash

# General stuff in xprofile.

run() {
    if ! pgrep -f "$1"; then
        "${@}" &
    fi
}

run sxhkd -c "$BSPWM_ROOT/sxhkdrc"

feh --bg-max "/home/poyehchen/Pictures/Wallpapers/104200866_p0.png" -B "#11111b"

eww -c "$EWW_ROOT" reload
eww -c "$EWW_ROOT" open bar

run "$SCRIPT_ROOT/watch-workspace"
run "$SCRIPT_ROOT/watch-volume"
run "$SCRIPT_ROOT/watch-mpd"

run polybar -c "$BSPWM_ROOT/polybar.ini"
polybar-msg cmd hide

run dunst
run light-locker

## Update Initial EWW variables
eww -c "$EWW_ROOT" update current-brightness="$(light -G)"
"$SCRIPT_ROOT/update-mpd"
"$SCRIPT_ROOT/update-volume"
"$SCRIPT_ROOT/update-mic"
