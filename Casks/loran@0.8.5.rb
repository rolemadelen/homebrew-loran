cask "loran@0.8.5" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.5"
  sha256 arm:   "6f1975697aa3a64dac47c449bc582af22a3b30748504eb721e3d6428f6416e79",
         intel: "0a89c605eca2419b6d7dce0a23533876d0584b2d059673fa73d2a1de00859610"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.5/loran-macosx-#{arch}-#{version}.dmg"
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
