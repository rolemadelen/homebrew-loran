cask "loran@0.8.4" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.4"
  sha256 arm:   "9347a09ddbee4a9267552e43f56af730deca79ccdef0bccec1f6cc7311df7077",
         intel: "f774e98dd58b31cbb1270c4463c4cbe8a7163bd929b460464e7634e69a5096ce"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.4/loran-macosx-#{arch}-#{version}.dmg"
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
