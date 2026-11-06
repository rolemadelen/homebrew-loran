cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.4"
  sha256 arm:   "87dc5a3bda275f3ff162388d7990993b6ceb50ef4b36c2d9191b21c52531c1b1",
         intel: "8b0311d036bc41f5c3d819ecb254008e68fe3a8229c1cd287e736f577b497298"

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
