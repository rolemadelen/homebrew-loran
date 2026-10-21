cask "loran@0.8.31" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.31"
  sha256 arm:   "58992159d2563eac8f8dfdd246889f2edd847330969f9a1c0e067a9f9a8ac08a",
         intel: "1ce5ad8c5b818c1244220dfe92bc29f4be79ffbc7a908609705ea111259699bf"

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
