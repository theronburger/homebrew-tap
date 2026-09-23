cask "key-session" do
  version "0.7.0"
  sha256 "87837f1743d836caa58d059b3aa8f7eec4f309475abe4ae33dcc6e44698f2495"

  url "https://github.com/theronburger/key-session/releases/download/v#{version}/key-session_#{version}_macos_universal.zip"
  name "Key Session"
  desc "Human-approved, consumer-scoped access to macOS Keychain secrets"
  homepage "https://github.com/theronburger/key-session"

  auto_updates true
  depends_on macos: :sonoma

  app "Key Session.app"
  binary "#{appdir}/Key Session.app/Contents/MacOS/key-session"

  uninstall quit: "com.theronburger.key-session",
            launchctl: "com.theronburger.key-session.daemon"

  zap trash: [
    "~/Library/Application Support/key-session",
    "~/Library/LaunchAgents/com.theronburger.key-session.daemon.plist",
    "~/Library/Preferences/com.theronburger.key-session.plist",
  ]

  caveats <<~EOS
    Key Session is self-signed because the project does not currently have an
    Apple Developer identity. After installing, explicitly remove Gatekeeper
    quarantine from only the Key Session app:

      brew tap theronburger/tap
      brew trust --cask theronburger/tap/key-session
      brew install --cask key-session
      xattr -dr com.apple.quarantine "/Applications/Key Session.app"

    Uninstall stops the app and Key Session daemon. Remove the MCP registrations
    too, so agents do not retain a path to the deleted app:

      codex mcp remove key-session
      claude mcp remove key-session --scope user
  EOS
end
