cask "loran@0.8.0" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.0"
  sha256 arm:   "4d5247d040dba6e3238dde1b8069fe96cbfd3741e53739d88d5d73952343dba5",
         intel: "5583754d2fe710a2c9f2160b9ff66da1ebe82c8b2f718ff06ef65c81083e0936"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.0/loran-macosx-#{arch}-#{version}.dmg"
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
