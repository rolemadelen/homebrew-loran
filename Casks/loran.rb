cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.21"
  sha256 arm:   "9b892e4144f5425a8aa9d82107c1256ce9c7de095e6d19b7a575b693245a7ebd",
         intel: "23e20eeecbe53f8c64bbc1179cc46f48bfdc99ddfec45f5698e37b671aa45e22"

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
