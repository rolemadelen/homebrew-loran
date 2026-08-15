cask "loran@0.7.16" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.16"
  sha256 arm:   "e1b85a5819a759a221378e4d061f771d709cfac752547b0fc75a0b2dc7e3688d",
         intel: "1d14072c0b5198aae222acde1f66bf982f51e465b1e350882472018f13dab337"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.16/loran-macosx-#{arch}-#{version}.dmg"
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
