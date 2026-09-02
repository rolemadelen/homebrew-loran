cask "loran@0.7.35" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.35"
  sha256 arm:   "3a77de5a8f08492a5343ca8e32f21d826c7f11e0a7771a7cc39f1765008f6e13",
         intel: "4346ae7f6a0d42d5c3543e358a41a9f800ef3dfce3d712d0220913b295cb6757"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.35/loran-macosx-#{arch}-#{version}.dmg"
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
