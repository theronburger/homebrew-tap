cask "lilt" do
  version "0.1.0"
  sha256 "b9763a6664f24f93838896d7e3a28ce8c498b6719f89623baee9f8bd32e3a74c"

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
