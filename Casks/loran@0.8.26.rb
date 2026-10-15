cask "loran@0.8.26" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.26"
  sha256 arm:   "9ba78b5a5bd3ee8696fe4f55dda9b2393cfb3cea85f991d5c9f577d86b227ba5",
         intel: "bf444097ad2095564e06f18da983485c132f92a4b7f6a97a52df8170672f0015"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.26/loran-macosx-#{arch}-#{version}.dmg"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

  # Same app name/bundle as the main cask — only one can be installed at a time
  conflicts_with cask: "loran"
  depends_on :macos

  app "loran.app"

  # Loran isn't Apple-notarized yet, so the quarantine flag set on
  # download would otherwise trigger Gatekeeper's "Apple could not
  # verify..." dialog on first launch. Stripping it here means brew
  # install is the only step a user needs - no right-click-Open dance.
  # A missing flag isn't an error.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{appdir}}/loran.app"],
        must_succeed: false,
        print_stderr: false
  end
end
