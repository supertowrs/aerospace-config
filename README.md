# AeroSpace + SketchyBar configuration

Personal macOS configuration for [AeroSpace](https://github.com/nikitabobko/AeroSpace) and [SketchyBar](https://github.com/FelixKratz/SketchyBar).

This branch is the verified snapshot taken immediately before installing
`omacosy` on 2026-08-25. It captures AeroSpace 0.21.2-Beta,
SketchyBar 2.24.0 and borders 1.9.0.

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

## MeetingBar shortcuts

`meetingbar.sh` uses MeetingBar's App Intents through these Apple Shortcuts:

- `SketchyBar MeetingBar Title`
- `SketchyBar MeetingBar Start`
- `SketchyBar MeetingBar Join`

SketchyBar refreshes the event every 30 seconds, hides the item when no event
is available, highlights meetings starting within five minutes and joins the
nearest meeting when clicked.

## Machine-specific values

The monitor assignments currently reference `LG HDR 4K`, `C32JG5x` and the built-in display. Adapt `[workspace-to-monitor-force-assignment]` in `aerospace.toml` if your display names differ.
