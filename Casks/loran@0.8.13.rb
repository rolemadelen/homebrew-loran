cask "loran@0.8.13" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.13"
  sha256 arm:   "f89260038978d19026a674e86952512266f9c47a8eaa56e6a15c23b2c60e1a37",
         intel: "c02745016dbec186fa48a8835c4f4b0e82e21adc72ad84194a1afac8144c57c1"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.13/loran-macosx-#{arch}-#{version}.dmg"
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
