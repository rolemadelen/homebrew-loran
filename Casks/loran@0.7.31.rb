cask "loran@0.7.31" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.31"
  sha256 arm:   "b5898aac089e7e19dd356a973f85c6a5a5ecc7e8a127283024e0633ad1aaf339",
         intel: "1a7fcb8e00d4b2b8307aa0ce02a3b98cfcec1aca656931b873a4a4888b24aa1c"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.31/loran-macosx-#{arch}-#{version}.dmg"
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
