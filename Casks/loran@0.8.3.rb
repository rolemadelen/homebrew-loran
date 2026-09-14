cask "loran@0.8.3" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.3"
  sha256 arm:   "365e2237ecf2bb1a72c92a1d16d0476a54ddae40292873f72a43b585af41c9f3",
         intel: "2d45e2961724ae3528d7f01ef8a6c97c8b632d6ac059e823d326aad53b0630ad"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.3/loran-macosx-#{arch}-#{version}.dmg"
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
