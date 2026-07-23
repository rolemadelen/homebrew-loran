cask "loran@0.7.1" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.1"
  sha256 arm:   "44d1c7fa1c8506e421d7772161e748b3fba59cc27072f01d090c951465487cb9",
         intel: "1f1205f59e935341867376b56cee6549621458bafe339fb75063eada8cf74431"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.1/loran-macosx-#{arch}-#{version}.dmg"
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
