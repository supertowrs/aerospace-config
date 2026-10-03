# Configuración de AeroSpace

Configuración personal de macOS con [AeroSpace](https://github.com/nikitabobko/AeroSpace), Karabiner y Ghostty. Tiling nativo, arranque automático y márgenes exteriores y separación entre ventanas a cero. Los atajos se mantienen tras retirar Omacosy; no depende de su barra, bordes, gestos, Overview ni autofocus.

## Contenido

- `aerospace.toml`: atajos, modos y nueve workspaces por monitor. El principal usa 1–9 y el secundario 11–19; el último dígito representa el mismo número en cada monitor.
- `scripts/workspace`, `scripts/cycle`, `scripts/float`: navegación por monitor, movimiento de ventanas y selección de ventanas de un mismo workspace, incluidas las flotantes. Usan el CLI de AeroSpace.
- `scripts/ghostty-window`: abre una ventana desde la instancia existente de Ghostty 1.3; si está cerrado, lo inicia con una sola ventana.
- `scripts/finder-window`: abre una ventana nueva de Finder en el workspace actual.
- `scripts/files`: abre Yazi en Ghostty cuando está instalado.
- `lock-screen.swift`: bloqueo de pantalla de macOS, ejecutado solo al pulsar su atajo.
- `shortcuts.txt`: hoja de atajos que abre `Caps + K`.
- `karabiner/karabiner.json`: Caps mantenido envía Cmd+Ctrl+Alt; Caps solo envía Escape. Incluye el procesamiento del Keychron K2 Pro (vendor 13364, product 545).
- `ghostty/config`: tamaño inicial, título oculto, apertura de ventanas y terminal rápido global con `Cmd + Escape`, además de salto de línea con `Shift + Enter`.
- `LICENSE.utilities`: licencia de las utilidades adaptadas del proyecto Omacosy.

## Instalación

Probado con AeroSpace 0.21.3-Beta y Ghostty 1.3.1. Requiere Karabiner-Elements para Caps, `swiftc` (Xcode Command Line Tools) para compilar el bloqueo y las aplicaciones que abren los atajos: Ghostty, Safari, Raycast, Spotify y Slack. Yazi es opcional.

Desde este repo:

```sh
mkdir -p ~/.config/aerospace/scripts
cp aerospace.toml shortcuts.txt LICENSE.utilities lock-screen.swift ~/.config/aerospace/
cp scripts/* ~/.config/aerospace/scripts/
swiftc ~/.config/aerospace/lock-screen.swift -o ~/.config/aerospace/scripts/lock-screen
chmod +x ~/.config/aerospace/scripts/*
open -a AeroSpace
aerospace reload-config --no-gui
```

Para adoptar también el perfil de teclado y los ajustes de Ghostty, los siguientes comandos sustituyen sus archivos de configuración. Guardan una copia de los existentes antes de copiarlos:

```sh
mkdir -p ~/.config/karabiner ~/.config/ghostty
for file in karabiner/karabiner.json ghostty/config; do
  if [ -f "$HOME/.config/$file" ]; then
    cp "$HOME/.config/$file" "$HOME/.config/$file.bak-$(date +%Y%m%d-%H%M%S)"
  fi
  cp "$file" "$HOME/.config/$file"
done
open -a Karabiner-Elements
```

En Karabiner, selecciona el perfil `AeroSpace` y activa **Modify events** para cada teclado que deba usar Caps. Ghostty también puede leer preferencias personales desde `~/Library/Application Support/com.mitchellh.ghostty/config`. Recarga su configuración con `Cmd + Shift + ,`.

## Atajos principales

`Super` significa Caps mantenido. Todos los atajos están en `shortcuts.txt`.

| Atajo | Acción |
| --- | --- |
| Super + Enter | Nueva ventana de Ghostty |
| Super + flechas | Enfocar una ventana |
| Super + Shift + flechas | Mover una ventana |
| Super + 1–9 | Workspace del monitor enfocado |
| Super + Shift + 1–9 | Mover una ventana al workspace y seguirla |
| Super + Tab / Shift + Tab | Siguiente / anterior workspace del monitor |
| Super + Shift + O | Mover una ventana al otro monitor, al mismo número |
| Super + Shift + Espacio | Mover todas las ventanas del workspace al otro monitor |
| Ctrl + Alt + Tab | Enfocar el siguiente monitor |
| Alt + Tab / Alt + Shift + Tab | Recorrer ventanas del workspace |
| Super + T / J / F | Flotante / orientación / pantalla completa |
| Super + Shift + F | Nueva ventana de Finder |
| Super + Shift + L | Bloquear pantalla |
| Super + K | Mostrar la hoja de atajos |

Los atajos para cambiar temas y fondos se retiraron junto con Omacosy. El panel de ayuda usa Quick Look y se cierra con Escape.
