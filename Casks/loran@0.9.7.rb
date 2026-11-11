cask "loran@0.9.7" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.7"
  sha256 arm:   "153f840790d74db794ecd97d25d05bc9b583cc1dc62c9384fa63ff2dcabff672",
         intel: "d4a57118f4bbdbb902cfed52541f008c52310900d1310bc206387f0151785d43"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.9.7/loran-macosx-#{arch}-#{version}.dmg"
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
