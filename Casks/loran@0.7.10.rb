cask "loran@0.7.10" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.10"
  sha256 arm:   "3d95ed1ac9714dadf80824b94d6f63ef5ed0f3de931c9d4b2938ed79042899d0",
         intel: "6e080a758fddc4815cd447b581803b49372b8a48462a65594e7839c647fd5166"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.10/loran-macosx-#{arch}-#{version}.dmg"
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
