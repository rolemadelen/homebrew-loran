cask "loran@0.7.6" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.6"
  sha256 arm:   "e03130dca46004653cc144b6ed45cbf32bb5eaf7c59dfae110eb7d6aa711fd5f",
         intel: "32edbfc71a8f72571a3835b8535f1d77eaf970351bed4a66c9b2bdd4324337dc"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.6/loran-macosx-#{arch}-#{version}.dmg"
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
