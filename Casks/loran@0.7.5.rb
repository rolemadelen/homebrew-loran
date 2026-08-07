cask "loran@0.7.5" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.5"
  sha256 arm:   "6c52d26481a0d01207164c0f86d292133f705787916665e80f0e52ecead19948",
         intel: "7f2702c29847ceaeee4b1c7d88381d2d952822c5a10a6dc09ce4cd4413a5fc5b"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.5/loran-macosx-#{arch}-#{version}.dmg"
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
