cask "loran@0.7.28" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.28"
  sha256 arm:   "7fd4299887a2ab6f1447c78bc206654624f02232699da8c923c6ec2bae2d153f",
         intel: "737e3a8490dc7989089c9b57fc4ec7e0918a994bb7fcff23f8568048d0f75d80"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.28/loran-macosx-#{arch}-#{version}.dmg"
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
