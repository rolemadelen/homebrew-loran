cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.31"
  sha256 arm:   "f93830afefd50021426b8988e2beea3be9816884eeb0199cc590d621af19cb7b",
         intel: "b4b7dcbb735b62d0bf8402147bb7c27a3be0daf5a124d8dfe82066dbdef7328e"

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
