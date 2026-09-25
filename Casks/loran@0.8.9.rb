cask "loran@0.8.9" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.9"
  sha256 arm:   "cc3b3de4602257e2a47a076c34ac09fdff7db3a49771b167e34a7b2c2a905d70",
         intel: "d5e27142900577ebba8e3f33cc69903a47480667cec83dfbd44702e0ace55ecc"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.9/loran-macosx-#{arch}-#{version}.dmg"
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
