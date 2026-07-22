cask "loran@0.6.1" do
  arch arm: "aarch64", intel: "intel"

  version "0.6.1"
  sha256 arm:   "a502cad72dd02498a5bccbe082075c41c434dbfdc4fb79251456b25b3d795839",
         intel: "83c13d223be7af0ef6530da6e8aa3bd663855623ace8ac3d24cc0b830eb3a871"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.6.1/loran-macosx-#{arch}-#{version}.dmg"
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
