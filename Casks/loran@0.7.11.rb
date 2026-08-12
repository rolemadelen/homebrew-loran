cask "loran@0.7.11" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.11"
  sha256 arm:   "6fc26d308a37edb784c8890060b3e7d03a3df684c562961691a0e7ddce9fa5ae",
         intel: "14cad222b10c5fecd6192028b4755c3c88ddff69c430a694698e68cb263f9ade"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.11/loran-macosx-#{arch}-#{version}.dmg"
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
