cask "loran@0.7.0" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.0"
  sha256 arm:   "ec345e121f0e34a2588b07f7a4142efd19b9722c7d5a4d5b0c7d68e5108118e0",
         intel: "00fc94155a779287328372d30f560531ae11d373f86b7da1529cb2d8bfc73363"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.0/loran-macosx-#{arch}-#{version}.dmg"
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
