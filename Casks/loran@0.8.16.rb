cask "loran@0.8.16" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.16"
  sha256 arm:   "461440992609436b82b27f79c58774aa78f4f4d2b72283b6e1d3100f71a4e70e",
         intel: "9dec5d782b546cfe9903ce37d6207b293f2a0709ca57d14c610130b03e10a9fb"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.16/loran-macosx-#{arch}-#{version}.dmg"
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
