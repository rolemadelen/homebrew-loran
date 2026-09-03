cask "loran@0.7.36" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.36"
  sha256 arm:   "ccce67d4b1bc79fc987380389d852a478cff7a487fc484d1571478c4782c7dc6",
         intel: "e20c5f2c7215d7650ed07d3b9e3f41613cf1853e02f58ee3ac04d813b654d620"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.36/loran-macosx-#{arch}-#{version}.dmg"
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
