cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.5"
  sha256 arm:   "f56dfd82d7825c67577c90ce6586ed5d2930d971155573978d59817788a0e20e",
         intel: "197cf7003f5598e33713bc81c5d76e8bb61e9b3eff0ddcfed6bde33ab83fe32f"

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
