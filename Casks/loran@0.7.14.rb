cask "loran@0.7.14" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.14"
  sha256 arm:   "2647062d30d2d297c24921c5972e66f81390def7c1973824c5481bfdc2271fe3",
         intel: "e431a5d80bba9bf33755813679829410c6139302882152684f2dd81d0801d28c"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.14/loran-macosx-#{arch}-#{version}.dmg"
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
