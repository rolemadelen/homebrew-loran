cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.25"
  sha256 arm:   "899b691a9a6cc9c5a38a73096482df79f1f27bf0577a369f03d471f3b9fd2808",
         intel: "153ddf23d30c8fd37fc1162c8dc7656f0ffc2e69dc61efa49b1bb5822cb19c1c"

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
