cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.24"
  sha256 arm:   "4d5d0c7d0fb6fefd0bf7ead842f4e13aa1f1eb8be0073ba6b8fd87be1404a9e5",
         intel: "2ad086756dcb38413bf29c4e032b875a5dc1d02d005d0a862e8360f6437b5553"

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
