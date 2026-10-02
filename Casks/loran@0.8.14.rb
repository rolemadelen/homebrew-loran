cask "loran@0.8.14" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.14"
  sha256 arm:   "538532e1a376d6df8b5ec55eae6b94bd51bab8adca8358005392cb619cc80980",
         intel: "5845400b26e4941e7bc86c672a212675d795b076ef4b8758121391ac3e112d2e"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.14/loran-macosx-#{arch}-#{version}.dmg"
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
