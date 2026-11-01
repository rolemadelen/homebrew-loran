cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.0"
  sha256 arm:   "880f1132b07fab104f45b1de44a11fc672adb1e995f32dbb9d9e86b71d7de428",
         intel: "2b55bdf5b018cbd007ddcbfe23922f387de008aea7bb16290e4abea8b49debd7"

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
