cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.6.2"
  sha256 arm:   "24b25dfa49160d915c1febf106b291b8aa826f97aa49aed4697d8110c0a7eee6",
         intel: "b23e2c354bc76531ad3e8a1df89c26bb4e0b278bd2bdeb3194550736310df658"

  url "https://pub-8cba8c3991e24de0bb09ab4fc11e167b.r2.dev/loran/loran-macosx-#{arch}-#{version}.dmg",
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
