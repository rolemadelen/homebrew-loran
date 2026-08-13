cask "loran@0.7.13" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.13"
  sha256 arm:   "d45fbfabcd422aad169794cab29103accd336bc4bdb5a83e42a85bebead1a4c1",
         intel: "b723fc19e4dce5579b01990f3d8020508bee042fabd1f009cc08394e8b7a1fea"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.13/loran-macosx-#{arch}-#{version}.dmg"
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
