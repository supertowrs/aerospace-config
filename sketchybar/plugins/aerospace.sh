#!/bin/sh

focused_workspace="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

if [ "$1" = "$focused_workspace" ]; then
  sketchybar --set "$NAME" \
             background.color=0x88ff00ff \
             background.border_width=2 \
             icon.shadow.drawing=on \
             label.shadow.drawing=on
else
  sketchybar --set "$NAME" \
             background.color=0x44ffffff \
             background.border_width=0 \
             icon.shadow.drawing=off \
             label.shadow.drawing=off
fi
