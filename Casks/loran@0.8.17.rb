cask "loran@0.8.17" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.17"
  sha256 arm:   "63f24ab78cfd9cff70e37fa2670b6c59785c5ccfe2b3058674110c8a1b1a8b5c",
         intel: "8a2a990627104f1102a1d978e9a28bb861f5ae484ce316bf77ec2b355035483e"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.17/loran-macosx-#{arch}-#{version}.dmg"
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
