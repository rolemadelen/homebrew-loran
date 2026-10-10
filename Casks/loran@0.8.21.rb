cask "loran@0.8.21" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.21"
  sha256 arm:   "67ac947164c4334809df9e984d7f86c500aa8bb2931b7dd8e6b579dc925a75fd",
         intel: "18f08a4fd8147cd4ad0f1fc089a0bf9208f10b53f973b96ae362548f2a0abd69"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.21/loran-macosx-#{arch}-#{version}.dmg"
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
