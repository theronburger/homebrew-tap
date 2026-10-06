cask "lilt" do
  version "0.2.0"
  sha256 "13b133b4627e88b40e2644f4d7d083a21d4fbd2c8f476e106fd4f154e44c42c1"

  url "https://github.com/theronburger/lilt/releases/download/v#{version}/lilt_#{version}_macos_arm64.zip"
  name "Lilt"
  desc "Read selected screen text aloud with word highlighting"
  homepage "https://github.com/theronburger/lilt"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "Lilt.app"
  uninstall quit: "app.lilt.reader"

  zap trash: [
    "~/Library/Application Support/Lilt",
    "~/Library/Preferences/app.lilt.reader.plist",
    "~/Library/Caches/app.lilt.reader",
  ]

  caveats <<~EOS
    Lilt is currently self-signed, not Apple-notarized. If macOS blocks the
    first launch, open System Settings > Privacy & Security and choose
    Open Anyway after attempting to open Lilt.
  EOS
end
