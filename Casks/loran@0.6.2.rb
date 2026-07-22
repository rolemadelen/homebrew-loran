cask "loran@0.6.2" do
  arch arm: "aarch64", intel: "intel"

  version "0.6.2"
  sha256 arm:   "24b25dfa49160d915c1febf106b291b8aa826f97aa49aed4697d8110c0a7eee6",
         intel: "b23e2c354bc76531ad3e8a1df89c26bb4e0b278bd2bdeb3194550736310df658"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.6.2/loran-macosx-#{arch}-#{version}.dmg"
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
