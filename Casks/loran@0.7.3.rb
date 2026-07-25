cask "loran@0.7.3" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.3"
  sha256 arm:   "4cbaf09296652a16773b874563fd72f8109676f8b3cec4bc3dc5c5b4467922a6",
         intel: "7617e17eb95e11b0e732ce9b41743a717ebf715034d658320c8ccd4700e86314"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.3/loran-macosx-#{arch}-#{version}.dmg"
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
