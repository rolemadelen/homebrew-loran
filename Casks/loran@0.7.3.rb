cask "loran@0.7.3" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.3"
  sha256 arm:   "856e7f389f4d17efaab114d924dfd8be46c39445e5d901150851a39e78443175",
         intel: "8f04aa9cfb0b4c93104903f9f20fa9874530d4814e45b6aee3ad70e55cd33614"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.3/loran-macosx-#{arch}-#{version}.dmg"
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
