cask "loran@0.7.34" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.34"
  sha256 arm:   "a251840a5539fa4c77965a6a3ea9e93ee5520bbd2255c953f14499ce34278bb6",
         intel: "4c409dfeb740a435d3116c12142f33af86a407387d0c6a8d0b7c685a78986b4d"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.34/loran-macosx-#{arch}-#{version}.dmg"
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
