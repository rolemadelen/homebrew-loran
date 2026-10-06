cask "loran@0.8.19" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.19"
  sha256 arm:   "82d0848206a80b5cad72594045d964ee927c50258f6f21c744152e50ce2fe5bf",
         intel: "4796e77413bac5f88955e7689e0dcfe3281128ab13d0ed1a070e6174d3c11c31"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.19/loran-macosx-#{arch}-#{version}.dmg"
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
