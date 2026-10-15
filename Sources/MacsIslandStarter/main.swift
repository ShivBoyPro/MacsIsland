import AppKit
import SwiftUI

// Public UI scaffold. All music content here is a static placeholder.
struct StarterView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "music.note")
                .font(.system(size: 18))
                .frame(width: 34, height: 34)
                .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 2) {
                Text("MacsIsland").font(.system(size: 13, weight: .semibold))
                Text("Static UI preview")
                    .font(.system(size: 10))
                    .foregroundStyle(.white.opacity(0.55))
            }
            Spacer(minLength: 12)
            HStack(spacing: 10) {
                placeholderButton("backward.fill", label: "Previous track")
                placeholderButton("play.fill", label: "Play")
                placeholderButton("forward.fill", label: "Next track")
            }
            Image(systemName: "waveform")
                .font(.system(size: 18))
                .foregroundStyle(.white.opacity(0.6))
                .accessibilityLabel("Decorative waveform")
        }
        .padding(.horizontal, 16)
        .frame(width: 340, height: 54)
        .foregroundStyle(.white)
        .background(.black, in: Capsule())
        .environment(\.colorScheme, .dark)
    }

    private func placeholderButton(_ symbol: String, label: String) -> some View {
        Button {} label: {
            Image(systemName: symbol).font(.system(size: 12))
        }
        .buttonStyle(.plain)
        .disabled(true)
        .accessibilityLabel(label + " — preview only")
    }
}

final class StarterAppDelegate: NSObject, NSApplicationDelegate {
    private var panel: NSPanel?
    private var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 340, height: 54),
                            styleMask: [.borderless, .nonactivatingPanel],
                            backing: .buffered, defer: false)
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = false
        panel.hidesOnDeactivate = false
        panel.isReleasedWhenClosed = false
        panel.level = .floating
        panel.contentView = NSHostingView(rootView: StarterView())
        if let screen = NSScreen.main {
            panel.setFrameOrigin(NSPoint(x: screen.visibleFrame.midX - 170,
                                          y: screen.visibleFrame.maxY - 68))
        }
        panel.orderFrontRegardless()
        self.panel = panel

        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.image = NSImage(systemSymbolName: "music.note", accessibilityDescription: "MacsIsland Starter")
        let menu = NSMenu()
        let toggle = NSMenuItem(title: "Show / Hide Preview", action: #selector(togglePreview), keyEquivalent: "")
        toggle.target = self
        menu.addItem(toggle)
        menu.addItem(.separator())
        let quit = NSMenuItem(title: "Quit MacsIsland Starter", action: #selector(quit), keyEquivalent: "q")
        quit.target = self
        menu.addItem(quit)
        item.menu = menu
        statusItem = item
    }

    @objc private func togglePreview() {
        guard let panel else { return }
        if panel.isVisible { panel.orderOut(nil) }
        else { panel.orderFrontRegardless() }
    }

    @objc private func quit() { NSApp.terminate(nil) }
}

let app = NSApplication.shared
let delegate = StarterAppDelegate()
app.setActivationPolicy(.accessory)
app.delegate = delegate
app.run()
