cask "loran@0.7.12" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.12"
  sha256 arm:   "ce10448ea7523005d22cb15d951909e12779a23f07bf775c13fb41e164b64757",
         intel: "2162a14fb441a93c1520bda757a63c714dd57050d9297e15500c3b96da2a8476"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.12/loran-macosx-#{arch}-#{version}.dmg"
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
