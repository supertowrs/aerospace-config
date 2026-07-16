#!/usr/bin/env bash

set -u

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
ICON_MAP="$CONFIG_DIR/plugins/icon_map.sh"
args=()

while IFS= read -r sid; do
  apps=()

  while IFS= read -r app; do
    if [ -n "$app" ]; then
      apps+=("$app")
    fi
  done < <(aerospace list-windows --workspace "$sid" --format '%{app-name}')

  icons=""
  if [ "${#apps[@]}" -gt 0 ]; then
    icons="$("$ICON_MAP" "${apps[@]}")"
  fi

  args+=(--set "space.$sid" label="$icons")
done < <(aerospace list-workspaces --all)

if [ "${#args[@]}" -gt 0 ]; then
  sketchybar "${args[@]}"
fi
