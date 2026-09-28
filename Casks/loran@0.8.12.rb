cask "loran@0.8.12" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.12"
  sha256 arm:   "6fcff3f20e786c581bfed6e50832f0c1928ad1b0e8042f636b2e50462d110d27",
         intel: "77926f3b776f8acf81de7c8a5f76f8c39ba94091907fd342fbec21ae2204dcb1"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.12/loran-macosx-#{arch}-#{version}.dmg"
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
