cask "loran@0.8.8" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.8"
  sha256 arm:   "9781d28bde8b5ca51c1346744b71ff324c0a78343daf88f4c7c6196909788275",
         intel: "345ab3f1c85699c4776170fc5dc79d9f0e2a75acfc5bca5a0685bd254ce4cf59"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.8/loran-macosx-#{arch}-#{version}.dmg"
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
