cask "loran@0.8.3" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.3"
  sha256 arm:   "8e19cf7d68922a15c7892963775ca10fc392e69019023713c62574723aad9e67",
         intel: "6fba2b9c413ed970889cce01e75ba98bbdd780b3c0622f3c2cdc78a3eee378b9"

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
