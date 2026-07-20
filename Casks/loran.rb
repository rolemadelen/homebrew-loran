cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.6.3"
  sha256 arm:   "dbb040fceb5dc66318a34af3c30789570666a403a16a1414578503856609e8fd",
         intel: "8c4a47a7bce81605feb0fc86df9c49219f0c335d89f79e4808f6b1e1f4e425c8"

  url "https://pub-8cba8c3991e24de0bb09ab4fc11e167b.r2.dev/loran/loran-macosx-#{arch}-#{version}.dmg",
      verified: "pub-8cba8c3991e24de0bb09ab4fc11e167b.r2.dev/loran/"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

  depends_on :macos

  app "loran.app"

  postflight do
    # Loran isn't Apple-notarized yet, so the quarantine flag set on
    # download would otherwise trigger Gatekeeper's "Apple could not
    # verify..." dialog on first launch. Stripping it here means brew
    # install is the only step a user needs - no right-click-Open dance.
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{appdir}/loran.app"],
                   sudo: false
  end
end
