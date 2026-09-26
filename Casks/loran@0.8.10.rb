cask "loran@0.8.10" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.10"
  sha256 arm:   "eb7551bf7ac66f728f8c984c62f72be06059a5eb44275d039259efad4865e77c",
         intel: "0cd2ef1017f38ab9795a02813bfa8efaa171faf0e911a938e2000be9a88508e0"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.10/loran-macosx-#{arch}-#{version}.dmg"
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
