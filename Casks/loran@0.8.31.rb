cask "loran@0.8.31" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.31"
  sha256 arm:   "a60e58ad68175bb12e7cb8181268fe85fd163ddfafa24bcc607d8da9ec9b7a56",
         intel: "ac9a22abe418568cb78a46e9cb998c97fedc4fa3a4accd7672ee817fb6c2c4b6"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.31/loran-macosx-#{arch}-#{version}.dmg"
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
