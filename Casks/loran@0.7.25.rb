cask "loran@0.7.25" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.25"
  sha256 arm:   "a808ba2dc32054606f18026c28188cbc638b6dea5ff0299cd5d908f970d335f8",
         intel: "81057c2eaa967da99082328858139e3c804a4584789bb9d36ed682c08b7e3492"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.25/loran-macosx-#{arch}-#{version}.dmg"
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
