cask "loran@0.8.18" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.18"
  sha256 arm:   "299188ee280a8abf8a22a7dd48d818d33dc85f57351ee673fe21484ee8aa6068",
         intel: "75f27a5cefc6d508a70faece5fee4342dc67d390f08702f30549ee187b256fee"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.18/loran-macosx-#{arch}-#{version}.dmg"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

  # Same app name/bundle as the main cask — only one can be installed at a time
  conflicts_with cask: "loran"
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
