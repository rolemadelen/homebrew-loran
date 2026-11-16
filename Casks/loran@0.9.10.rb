cask "loran@0.9.10" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.10"
  sha256 arm:   "10ba17625049222da09c3c9be0d528651ecbdf47b9e2a4a176a840435ddb79b1",
         intel: "9e9553452bb22302830f6820853d01b623805b7a64c3201479d28642067b823d"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.10/loran-macosx-#{arch}-#{version}.dmg"
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
