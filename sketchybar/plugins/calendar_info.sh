#!/usr/bin/env bash

SHORTCUT_NAME="SketchyBar Next Meeting"
MAX_TITLE_LENGTH=24
ERROR_FILE="${TMPDIR:-/tmp}/sketchybar-calendar-error.log"

if ! EVENT_INFO=$(/usr/bin/shortcuts run "$SHORTCUT_NAME" 2>"$ERROR_FILE"); then
  sketchybar --set "$NAME" drawing=on icon="󰸘" label="Calendar error"
  exit 1
fi

if [ -z "$EVENT_INFO" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

TITLE="${EVENT_INFO%%|*}"
START_TEXT="${EVENT_INFO#*|}"

if [ "$START_TEXT" = "$EVENT_INFO" ] || [ -z "$TITLE" ] || [ -z "$START_TEXT" ]; then
  sketchybar --set "$NAME" drawing=on icon="󰸘" label="Calendar error"
  exit 1
fi

if [ "${#TITLE}" -gt "$MAX_TITLE_LENGTH" ]; then
  TITLE="${TITLE:0:$MAX_TITLE_LENGTH}…"
fi

if ! START_EPOCH=$(/bin/date -j -f "%d %b %Y at %H:%M" "$START_TEXT" "+%s" 2>>"$ERROR_FILE"); then
  sketchybar --set "$NAME" drawing=on icon="󰸘" label="Calendar error"
  exit 1
fi

NOW_EPOCH=$(/bin/date "+%s")
SECONDS_LEFT=$((START_EPOCH - NOW_EPOCH))

if [ "$SECONDS_LEFT" -le 0 ]; then
  TIME_LEFT="now"
else
  MINUTES_LEFT=$(((SECONDS_LEFT + 59) / 60))

  if [ "$MINUTES_LEFT" -gt 1440 ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
  fi

  if [ "$MINUTES_LEFT" -lt 60 ]; then
    TIME_LEFT="${MINUTES_LEFT}m"
  else
    HOURS_LEFT=$((MINUTES_LEFT / 60))
    EXTRA_MINUTES=$((MINUTES_LEFT % 60))

    if [ "$EXTRA_MINUTES" -eq 0 ]; then
      TIME_LEFT="${HOURS_LEFT}h"
    else
      TIME_LEFT="${HOURS_LEFT}h ${EXTRA_MINUTES}m"
    fi
  fi
fi

LABEL="${TITLE} - ${TIME_LEFT}"
sketchybar --set "$NAME" drawing=on icon="󰸘" label="$LABEL"
