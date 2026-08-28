cask "loran@0.7.29" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.29"
  sha256 arm:   "8199056a552319613068ce08ae39bee10125ee0ae008a81320c5c085b53e054c",
         intel: "5e750bc068afb3d841d64839e77993ccf82cdca68a181282e9035a63d96ac9a6"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.29/loran-macosx-#{arch}-#{version}.dmg"
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
