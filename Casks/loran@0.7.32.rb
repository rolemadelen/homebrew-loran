cask "loran@0.7.32" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.32"
  sha256 arm:   "7a5233b068eeeefedbf91df8a8583919b3c01bf3b83ed1685f869d75bb3f3190",
         intel: "c4792cc22c1956df6c6613420bb91ada23f19758690a3f7c2f88baf8dc13f12d"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.32/loran-macosx-#{arch}-#{version}.dmg"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

  # Same app name/bundle as the main cask — only one can be installed at a time
  conflicts_with cask: "loran"
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
