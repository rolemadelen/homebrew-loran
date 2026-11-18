cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.11"
  sha256 arm:   "5dba97a1f332cbf01ef4b51b833d259c17bb2c24a01b434f4faed9fc2419b7d2",
         intel: "cb4176152e5e65da69aba3f3e40f1bda00e9217e9ecaf1bb019136f8e15d0fc6"

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
