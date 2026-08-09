cask "loran@0.7.7" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.7"
  sha256 arm:   "ce6bcd79458866275716807d4a6d0b087bf80f4396f20e19d0684c5cd0a6f179",
         intel: "8b84bcf830ceff315362af48c26b82351c995068e6e7a792da54194a17c5683f"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.7/loran-macosx-#{arch}-#{version}.dmg"
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
