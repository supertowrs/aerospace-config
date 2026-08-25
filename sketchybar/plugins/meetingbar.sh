#!/usr/bin/env bash

SHORTCUTS="/usr/bin/shortcuts"
SKETCHYBAR="/opt/homebrew/bin/sketchybar"
ITEM_NAME="${NAME:-meetingbar}"

hide_item() {
  "$SKETCHYBAR" --set "$ITEM_NAME" drawing=off
  exit 0
}

meeting_title="$($SHORTCUTS run "SketchyBar MeetingBar Title" 2>/dev/null)" || hide_item
meeting_start="$($SHORTCUTS run "SketchyBar MeetingBar Start" 2>/dev/null)" || hide_item

meeting_title="$(/usr/bin/printf '%s' "$meeting_title" | /usr/bin/tr '\r\n' '  ' | /usr/bin/sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//; s/[[:space:]]+/ /g')"
meeting_start="$(/usr/bin/printf '%s' "$meeting_start" | /usr/bin/tr -d '\r\n')"

[[ -n "$meeting_title" && -n "$meeting_start" ]] || hide_item

# Shortcuts emits ISO 8601. BSD date expects a timezone without a colon and
# does not accept fractional seconds, so normalize both before parsing.
normalized_start="$(/usr/bin/printf '%s' "$meeting_start" \
  | /usr/bin/sed -E 's/\.[0-9]+([+-]|Z)/\1/; s/Z$/+0000/; s/([+-][0-9]{2}):([0-9]{2})$/\1\2/')"
start_epoch="$(/bin/date -j -f '%Y-%m-%dT%H:%M:%S%z' "$normalized_start" '+%s' 2>/dev/null)" || hide_item

now_epoch="$(/bin/date '+%s')"
seconds_until=$((start_epoch - now_epoch))

if (( seconds_until <= 0 )); then
  countdown="ahora"
elif (( seconds_until < 3600 )); then
  minutes_until=$(((seconds_until + 59) / 60))
  countdown="en ${minutes_until} min"
elif (( seconds_until < 86400 )); then
  hours_until=$((seconds_until / 3600))
  minutes_until=$(((seconds_until % 3600) / 60))
  if (( minutes_until == 0 )); then
    countdown="en ${hours_until} h"
  else
    countdown="en ${hours_until} h ${minutes_until} min"
  fi
else
  countdown="$(/bin/date -r "$start_epoch" '+%a %H:%M' 2>/dev/null)" || hide_item
fi

if (( ${#meeting_title} > 32 )); then
  meeting_title="${meeting_title:0:31}…"
fi

label_color="0xffffffff"
if (( seconds_until > 0 && seconds_until <= 300 )); then
  label_color="0xffff9f0a"
fi

"$SKETCHYBAR" --set "$ITEM_NAME" \
  drawing=on \
  label="${meeting_title} · ${countdown}" \
  label.color="$label_color"
