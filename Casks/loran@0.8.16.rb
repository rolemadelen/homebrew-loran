cask "loran@0.8.16" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.16"
  sha256 arm:   "f2044eba71864c7bacf8179267dce3e743cc84471d5e7c20ab94e490e73a0cb5",
         intel: "e4cb3b2d0a7ad7e470a575137e81935492d1002c8ff40f153b1f1480b72eb68a"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.16/loran-macosx-#{arch}-#{version}.dmg"
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
