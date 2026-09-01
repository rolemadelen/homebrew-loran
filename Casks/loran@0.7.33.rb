cask "loran@0.7.33" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.33"
  sha256 arm:   "d01b053d26a44f9703fffd82ca9d7036b115de9d81c5ec8f2c5206529477efd8",
         intel: "8f8a873d80fca16831b86a5fe2a369623669c42999d737150c9299d8468225e4"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.33/loran-macosx-#{arch}-#{version}.dmg"
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
