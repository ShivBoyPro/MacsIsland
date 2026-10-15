#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This starter app requires macOS."
    exit 1
fi
case "${1:-}" in
    ""|--build-only) ;;
    *) echo "Usage: bash build.command [--build-only]"; exit 2 ;;
esac
if ! xcrun --find swift >/dev/null 2>&1; then
    echo "Install Xcode Command Line Tools with: xcode-select --install"
    exit 1
fi

swift build -c release
BIN_DIR="$(swift build -c release --show-bin-path)"
APP_DIR="$PWD/dist/MacsIslandStarter.app"
mkdir -p "$APP_DIR/Contents/MacOS"
cp "$BIN_DIR/MacsIslandStarter" "$APP_DIR/Contents/MacOS/MacsIslandStarter"
cat > "$APP_DIR/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>MacsIslandStarter</string>
<key>CFBundleIdentifier</key><string>dev.shivboypro.macsisland.starter</string>
<key>CFBundleExecutable</key><string>MacsIslandStarter</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>CFBundleVersion</key><string>1</string>
<key>LSMinimumSystemVersion</key><string>13.0</string>
<key>LSUIElement</key><true/>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
codesign --force --sign - "$APP_DIR"
echo "Built: $APP_DIR"
if [[ "${1:-}" != --build-only ]]; then
    open -n "$APP_DIR"
fi
