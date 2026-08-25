cask "loran@0.7.26" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.26"
  sha256 arm:   "550d06422940fd6c4b09a76befa4daf47fc11ace57cedfa1ce53cfbd0de445b6",
         intel: "3b60c3df2c9abfa32ccc31ec98260e9d25aedbf90ec1a7d63b219fb0cca01b3b"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.26/loran-macosx-#{arch}-#{version}.dmg"
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
