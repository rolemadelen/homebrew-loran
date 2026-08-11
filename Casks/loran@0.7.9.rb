cask "loran@0.7.9" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.9"
  sha256 arm:   "33d4de51f2f2ba38bf577789b5a8b97664cb816e93ac948cbf0ef106d5a953b8",
         intel: "eb2f9363ef0bc1729d88aac4568f1566d29c7905d7bcad789d884bf1c89f630f"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.9/loran-macosx-#{arch}-#{version}.dmg"
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
