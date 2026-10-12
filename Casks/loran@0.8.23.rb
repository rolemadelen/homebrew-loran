cask "loran@0.8.23" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.23"
  sha256 arm:   "eb8ca1878868ce5f85ffdf469bee1f5b34ed6ee755a2dfae13dda48e7c3a6092",
         intel: "4fcb43168802d1a19aeb6029f7d956908686ea826c754216f01b3ae537d689fa"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.23/loran-macosx-#{arch}-#{version}.dmg"
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
