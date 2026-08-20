cask "key-session" do
  version "0.6.0"
  sha256 "029d30ba18cc0a3037393b7b024d9e52f8d3b5f5ea98b11733e050d46d2a2d74"

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
