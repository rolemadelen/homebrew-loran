cask "loran@0.8.7" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.7"
  sha256 arm:   "5176331a407e37ec1acb0421c5caf09b3945673440344ad50c91eb5f0b916847",
         intel: "1bccf2cccc413de0e61ea358aa30974bc54653e22f4aea39eb7ca0b549f66e39"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.7/loran-macosx-#{arch}-#{version}.dmg"
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
