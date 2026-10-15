# MacsIsland

A music-focused desktop interface experiment built with **SwiftUI and AppKit**.

This is the public starter for the project: a small, runnable macOS app showing the initial panel layout and menu bar setup. The full application is developed separately and its implementation remains private.

## Public starter progress

- [x] Native macOS app entry point
- [x] Music-note menu bar icon
- [x] Floating, transparent window with a black capsule
- [x] Placeholder artwork, track text, and playback buttons
- [x] Show / Hide and Quit menu actions
- [x] Run without a Dock icon

The starter displays a static UI preview. Playback buttons are disabled; the waveform is decorative. It does not read your music, record audio, or request media permissions.

## Run locally

Requires macOS 13 or later and Xcode Command Line Tools.

```bash
git clone https://github.com/ShivBoyPro/MacsIsland.git
cd MacsIsland
bash build.command
```

The script builds and opens `dist/MacsIslandStarter.app`. Use the music-note menu to show or hide the preview, or quit. You can also run the app from Finder after building it.

To compile and package without launching:

```bash
bash build.command --build-only
```

## Project structure

```text
Package.swift
Sources/MacsIslandStarter/main.swift
build.command
```

The public code is intentionally small and self-contained. Advanced visual effects, custom animation physics, live audio analysis, and Apple Music integration are not included in this repository.

## Status

Active personal project. This repository documents the foundation and provides a basic interface preview.
