cask "loran@0.9.12" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.12"
  sha256 arm:   "01d845d0373c362e791321389be16e7dca3e47e3c859f02742f9a152cc7b2f28",
         intel: "1bfb923ae21473fa89abc89979b0916084e59952b60c0ed5f3477316d082b301"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.12/loran-macosx-#{arch}-#{version}.dmg"
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
