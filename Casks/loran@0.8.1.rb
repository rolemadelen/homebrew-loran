cask "loran@0.8.1" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.1"
  sha256 arm:   "b1667ee41c77fe17a3d226cd1488e61bb9e0f2401dbf14e5b2780b43fc7a5c0a",
         intel: "831027f8b2906d1e465e2aea254467296dd7c6b76f7dab97e959690d88a5953c"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.1/loran-macosx-#{arch}-#{version}.dmg"
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
