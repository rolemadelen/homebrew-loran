cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.2"
  sha256 arm:   "a38dfe38b7ee2eb6864476c491bbf2aca18d64156f4983bc7e2d7ad35f6722d1",
         intel: "336ced336dc3222b0beb2a1f22ebdbb317ad46f85c7024c3f219ce56af5ae418"

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
