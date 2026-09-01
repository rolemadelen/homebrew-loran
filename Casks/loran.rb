cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.33"
  sha256 arm:   "4a124feaf5626a549a9db67b729bfa4dec272a0714238093b75c1460ff7e3a50",
         intel: "62e86a64b867fced3486ae9aa10fd6915cfeec74336f9fe8c4d4e383b81416b1"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v#{version}/loran-macosx-#{arch}-#{version}.dmg",
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
