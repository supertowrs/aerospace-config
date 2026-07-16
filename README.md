# AeroSpace + SketchyBar configuration

Personal macOS configuration for [AeroSpace](https://github.com/nikitabobko/AeroSpace) and [SketchyBar](https://github.com/FelixKratz/SketchyBar).

## Included

- `aerospace.toml`: workspaces 1–9, keyboard bindings, monitor assignments and SketchyBar startup/events.
- `sketchybar/sketchybarrc`: compact 34 px bar with workspaces on every display.
- `sketchybar/plugins/`: workspace application icons, active workspace styling, battery, volume, clock and next meeting.

## Install

```bash
mkdir -p ~/.config/aerospace ~/.config/sketchybar
cp aerospace.toml ~/.config/aerospace/aerospace.toml
cp -R sketchybar/. ~/.config/sketchybar/
chmod +x ~/.config/sketchybar/sketchybarrc ~/.config/sketchybar/plugins/*.sh
```

The bar uses `Hack Nerd Font` for status icons and `sketchybar-app-font` for application icons.

## Calendar shortcut

`calendar_info.sh` requires an Apple Shortcut named `SketchyBar Next Meeting`. It must:

1. Find Calendar events whose start date is within the next 7 days and which are not all-day events.
2. Sort by start date and limit the result to one event.
3. Get the event title and start date.
4. Produce a Text value in the form `<Title>|<Start Date>`.
5. Stop and output that Text value.

SketchyBar renders the result as `Meeting title - 1h 14m`, refreshes it every 30 seconds and hides it when the event is more than 24 hours away.

## Machine-specific values

The monitor assignments currently reference `LG HDR 4K`, `C32JG5x` and the built-in display. Adapt `[workspace-to-monitor-force-assignment]` in `aerospace.toml` if your display names differ.
