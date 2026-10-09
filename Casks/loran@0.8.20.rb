cask "loran@0.8.20" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.20"
  sha256 arm:   "49e61b7464db753522557fdd88e12851aa1b16612e62b3979f6917e2fd78cb99",
         intel: "be6f596329833768f4a932b8f60a624e569a0525a12ee059d4194ced2ccb44fc"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.20/loran-macosx-#{arch}-#{version}.dmg"
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
