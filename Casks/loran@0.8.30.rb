cask "loran@0.8.30" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.30"
  sha256 arm:   "558ebc5a78bf040672e29a804bdd0e28562ee4e2b45866d2b1a99c49c0ad2384",
         intel: "1060e503e034a66d21592c19481a3581b27d12321213230fa222100981dac05a"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.30/loran-macosx-#{arch}-#{version}.dmg"
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
