cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.3"
  sha256 arm:   "4cbaf09296652a16773b874563fd72f8109676f8b3cec4bc3dc5c5b4467922a6",
         intel: "7617e17eb95e11b0e732ce9b41743a717ebf715034d658320c8ccd4700e86314"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.0/loran-macosx-#{arch}-#{version}.dmg",
      verified: "pub-8cba8c3991e24de0bb09ab4fc11e167b.r2.dev/loran/"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

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
