cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.21"
  sha256 arm:   "c0d3296ffd66c5eccf8fd1fe7790c5012a348a5f73f5c67f0dc0db6c15ac95df",
         intel: "15f80cf588bd34386b6da5774cbc391c72d298e3601c1d3537a3c4874e7c452d"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v#{version}/loran-macosx-#{arch}-#{version}.dmg"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

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
