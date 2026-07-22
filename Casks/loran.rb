cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.0"
  sha256 arm:   "cc8df51d53bd863702c5ce5bd486f82270090a8dcfea359fc7473cda11548b98",
         intel: "04a0a7675f5ba8704b8ea0b609c0d192d5cd8c6d926777d15d851cf285795b85"

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
