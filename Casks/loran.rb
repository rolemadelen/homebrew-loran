cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.6.2"
  sha256 arm:   "7e3304c68eb5312fe401d8edc9a47bb7e9d01ee5caec8cb8e5a024d743280a3f",
         intel: "496bbf48f34944669009251147ee7be7665716df525b1e36aa817fbeb9dc3f45"

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
