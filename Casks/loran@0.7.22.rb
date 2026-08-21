cask "loran@0.7.22" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.22"
  sha256 arm:   "b2633ae9389064220827a1882367a7031d2d68ec730c7bcfbb97458809784813",
         intel: "bd13473f9095cc2ba9ab29d23eeef166eb8ae5162dec95fe509ea06e51f6e736"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.22/loran-macosx-#{arch}-#{version}.dmg"
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
