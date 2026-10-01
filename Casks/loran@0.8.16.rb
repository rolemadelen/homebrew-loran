cask "loran@0.8.16" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.16"
  sha256 arm:   "b013194642510b90aff8b71c9c6c18eab8b43301dedc6d3f9ec3596431a853b5",
         intel: "13e18024fac212bf6f491445981ec577804d4c8fdcdab849bc8263cebe40914b"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.16/loran-macosx-#{arch}-#{version}.dmg"
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
