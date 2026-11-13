cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.9"
  sha256 arm:   "a91db48eebcee4ca2df9f031fba0e0f566b7e46b0c50c4014febd80d173ec7d1",
         intel: "11bb6cfd890ce01df4a2e19836f2cbfdff28d8fd1d485758ca997d3a45787940"

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
