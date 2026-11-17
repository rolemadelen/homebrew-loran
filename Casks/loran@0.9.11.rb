cask "loran@0.9.11" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.11"
  sha256 arm:   "0696f4ff76e57f45c03cf1dece7575d4a3f1eb6e8d5fc23895fc8ee456649a9b",
         intel: "f8f1417cd43b2a4fb2ead957da3e499fc915f237dfde28547403dd14cd9f214f"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.11/loran-macosx-#{arch}-#{version}.dmg"
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
