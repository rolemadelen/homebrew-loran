cask "loran@0.7.24" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.24"
  sha256 arm:   "1d7b3098ac3f20efb462a342f50b7ae33ea073ae62e02d67406935e10b9f6827",
         intel: "f0b58f48b8fdd0f49505282dde582904dcfdb8ba32a8f729de20c4639031cdcc"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.24/loran-macosx-#{arch}-#{version}.dmg"
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
