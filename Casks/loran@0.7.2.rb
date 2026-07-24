cask "loran@0.7.2" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.2"
  sha256 arm:   "96912ef7d551a3288f8c4822e18c14577b1f3762e3a1ea90d560d3ed6d5eda24",
         intel: "afdeb3794ee1abd1f2978fe109b06b7f3e90741c40d6f240abfaf2fbf76f050b"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.2/loran-macosx-#{arch}-#{version}.dmg"
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
