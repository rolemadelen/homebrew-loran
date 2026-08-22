cask "loran@0.7.23" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.23"
  sha256 arm:   "0e054ff999d3cfc3d2998ad296100c916d52a971a7e9e8d0be8b4dd18f3a98b8",
         intel: "3f554b3dc9aeba6502bb243c9cc1dbcf843ce06387555efd5c008969d3be8807"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.23/loran-macosx-#{arch}-#{version}.dmg"
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
