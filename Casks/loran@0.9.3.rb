cask "loran@0.9.3" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.3"
  sha256 arm:   "50bbceefb6c12fb068eb4754aff608ee1daf825c750e3f3773548aec5c3b1e9b",
         intel: "61762790a772c9b2e573b3f52054e5f787afe9d8d45b49d6c889b2f6c759fb79"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.3/loran-macosx-#{arch}-#{version}.dmg"
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
