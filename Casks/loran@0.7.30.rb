cask "loran@0.7.30" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.30"
  sha256 arm:   "f4387b380018a8c11dabf24eafb7005c4fc6c77947fde2bf43b437ba2a17821d",
         intel: "2a2ca06c21275deb93e4908758fde8a3c90535dccce6d96c1d8bedf1cff061da"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.30/loran-macosx-#{arch}-#{version}.dmg"
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
