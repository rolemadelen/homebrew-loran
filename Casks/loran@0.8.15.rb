cask "loran@0.8.15" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.15"
  sha256 arm:   "40b85ffb1feb0709512998a9afa9762cb03799e095c4ea4083b86aee29b3a456",
         intel: "e5bf3ab5302e80ff4dee2850bc7fcace99bfadd68ea4a540fcee0c5184f772d8"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.15/loran-macosx-#{arch}-#{version}.dmg"
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
