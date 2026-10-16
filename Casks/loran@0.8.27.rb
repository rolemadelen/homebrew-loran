cask "loran@0.8.27" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.27"
  sha256 arm:   "eac4cc4c8caddca062b002fa0544ad594ef31a99a3b41c78e9f5b008838300dc",
         intel: "3de6fcf9793f5c99c485d6752b519ebb963f7dc706a41c7660f914e5b30d6626"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.27/loran-macosx-#{arch}-#{version}.dmg"
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
