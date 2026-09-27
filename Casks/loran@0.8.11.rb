cask "loran@0.8.11" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.11"
  sha256 arm:   "945e0f0c535cb9d0d3ccbd69bbab5543bb5f4aef18a3ad9b9b10a8111eb7ac2e",
         intel: "522648224e0b524f3380b98b734a31046f19f5a5defb49bc4d308b967827b94a"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.11/loran-macosx-#{arch}-#{version}.dmg"
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
