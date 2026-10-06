cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.19"
  sha256 arm:   "209c64d0e47ce1c8b2eb7ddae1c1e01c9e1aa13628249908ba2fa218e7c9281d",
         intel: "521135d0e5ad344e94d04113367741495fa9dd2eb22d89c7d131d4c2e38bec76"

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
