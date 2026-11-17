cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.11"
  sha256 arm:   "fe56036ac365bbd2d88edbb59788ff72ca0c27792c80b8df8d36695bdf00f8f5",
         intel: "54aba6defb69e6d1fbc016212c99244968c6411f4ef2788120fdf63c68552830"

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
