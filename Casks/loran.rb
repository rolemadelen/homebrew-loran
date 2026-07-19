cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.6.0"
  sha256 arm:   "39eb9e39300a3dcbf132d11e9e18289e2e388eabdf4b02c40bb0755fc8a759f7",
         intel: "fa89981cd49eb00d50d80c557e053a4747887e873e201c19f26883b10dd48359"

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
