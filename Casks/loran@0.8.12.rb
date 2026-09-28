cask "loran@0.8.12" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.12"
  sha256 arm:   "bed8d43053534affad9314ddfdc28d298700a5ec7f4b928e328e1767fbcfe727",
         intel: "399521619f6e8e30e936d6f702292589fb05ccc0a27a69b50eb61f424b3c5246"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.12/loran-macosx-#{arch}-#{version}.dmg"
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
