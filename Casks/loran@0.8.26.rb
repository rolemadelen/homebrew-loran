cask "loran@0.8.26" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.26"
  sha256 arm:   "293b635b2fcb5ddef049d80ad299f5a40e2e1a02acc088690cafaa2e6cc7bbc0",
         intel: "395634ebbae307586c32efd427f0e71f91d58f66917da3925e87c607cca05310"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.26/loran-macosx-#{arch}-#{version}.dmg"
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
