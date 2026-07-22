cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.0"
  sha256 arm:   "897c107c5ad57e2a138fef5acca87505339f3f81fc3ae4bdb95be6e0a5e370b6",
         intel: "395a38d32e7a3674a34cc82348045670998427bc5456a7c3d71a9a28a800fe7b"

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
