cask "loran@0.7.15" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.15"
  sha256 arm:   "004ddb7da5238642f218c2379afe145c97059bc2c66888083f1d88cc07810d61",
         intel: "47b2833cebcc9fce502163c7f0ecaccb97dd7199f0e77e019584ef292d704c41"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.15/loran-macosx-#{arch}-#{version}.dmg"
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
