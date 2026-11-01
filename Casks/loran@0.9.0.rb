cask "loran@0.9.0" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.0"
  sha256 arm:   "c80f4cd3dbcfa1ce66569073d5a78257d087ae79f2b3defe8189db6abac906c6",
         intel: "db4719d008e9404bdae16b7de82ec44d19eb97a441150e791ff5a7ee96b8aab9"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.0/loran-macosx-#{arch}-#{version}.dmg"
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
