cask "loran@0.8.14" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.14"
  sha256 arm:   "9ef6a01aac261c39e919ccb2e06ed4b732b11eaad5e139428449b0289a6a87ee",
         intel: "2df72eaf10946fb1a2ab40e19ad6ef80b998794c0e5edaa64fc3ee27d824a0f5"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.14/loran-macosx-#{arch}-#{version}.dmg"
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
