cask "loran@0.7.4" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.4"
  sha256 arm:   "621caa954f0ee9a2f54a10e1ffbd1efbf0a5024be83b2fba7860642fefdacff1",
         intel: "446e7cd9395dec5453e82dd1103cc43524e7134e97aa0c907c6d47d190b86e1f"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.4/loran-macosx-#{arch}-#{version}.dmg"
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
