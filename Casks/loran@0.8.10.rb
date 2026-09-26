cask "loran@0.8.10" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.10"
  sha256 arm:   "63a381c6482c93656b0de9979030e3a4618c2241bf7595b305287afc08111507",
         intel: "5cd4b72a6c9af6f2d52f6f17d7966b4280963a8936f1738e67611e12acb3644f"

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
