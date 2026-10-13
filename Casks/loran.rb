cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.24"
  sha256 arm:   "08d1d86668eda561ebe92249362855942af523e42f5ce8aa3c5f1a1dea593ca0",
         intel: "e770c546d7b29e62f7be236dae488cbee95b21474b4c975f8d4fc048b3f3b9c9"

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
