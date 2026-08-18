cask "loran@0.7.18" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.18"
  sha256 arm:   "d029c632caed102abbe695ebb9b134a8b1b31817433c082729469ce6a5fc746e",
         intel: "8c6f9730a318ea931f04ca75bb216ee752eec7f3bd946aaa119a4c0b4d0894cc"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.18/loran-macosx-#{arch}-#{version}.dmg"
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
