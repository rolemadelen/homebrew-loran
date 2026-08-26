cask "loran@0.7.27" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.27"
  sha256 arm:   "a203b7e270c79b613a2102c16abee87a7b623950ebac139f54f499bdef044a78",
         intel: "5eacd52d140bead8927cc4214e2796238074b0ed2971f66b0f3276e99c2be4a8"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.27/loran-macosx-#{arch}-#{version}.dmg"
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
