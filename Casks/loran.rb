cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.8"
  sha256 arm:   "27bd27e5728b64f699fbfa33af1edc69ebd51e0e1c12c533ef294b7824996b90",
         intel: "dea6870f6c273bdd3a5e3065ec908748e18d38c2e1b61ac368771e92f83716cc"

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
