cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.24"
  sha256 arm:   "5b9857dd534cae80e4c080f7fa499072ec35a2dfafe7f9b3167be3773e10059f",
         intel: "1e633ec931ab22ca2ca1ced8738cca8678897e76022b549746414fbcfd1aa2fa"

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
