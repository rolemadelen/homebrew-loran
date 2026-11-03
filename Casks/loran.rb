cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.1"
  sha256 arm:   "93ac673b6570b2948486f7376ee6a1acea4c607f4e7fba3bb1d6ec57c6a576a8",
         intel: "1a16dc61e254677e66a813bc1e6c2df21c84a52bbaa6e58b86861cc932b04f85"

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
