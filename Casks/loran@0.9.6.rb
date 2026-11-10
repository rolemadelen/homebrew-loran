cask "loran@0.9.6" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.6"
  sha256 arm:   "b8d084fd0b4b67825f43423eb5c20318a82d86db2fd802e0bd574018796c22fb",
         intel: "1aee05c633d69568d65fd705ba87ce86b6586e43cdcd8a0f2a67305a8907fa0e"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.6/loran-macosx-#{arch}-#{version}.dmg"
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
