cask "loran@0.7.7" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.7"
  sha256 arm:   "7c8b683706391ab187f22890c619da2136d367cb82108ae1cb5d53729955d6d2",
         intel: "bf0d829cfe7f5b9ff7e05c92221c21162a3e8f0c10f6146888da5e3d4d8bf5e8"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.7/loran-macosx-#{arch}-#{version}.dmg"
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
