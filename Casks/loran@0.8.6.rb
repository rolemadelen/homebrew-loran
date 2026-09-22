cask "loran@0.8.6" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.6"
  sha256 arm:   "1b33e0e92e2ec41aad24cfc6aff404802d19bf9d282de9ed5e3c082f79d21237",
         intel: "1bdad47edb542d01f972ac9305dc94c222eb250cca821a879a4b5698e04ad5f2"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.6/loran-macosx-#{arch}-#{version}.dmg"
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
