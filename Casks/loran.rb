cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.19"
  sha256 arm:   "33496180004ecf8a40363a1aecee2147c562d9342bab82aa3fb31c72c708a6f6",
         intel: "fa4b3c3db2e8984408af1fdb3310aed0e86e9efb81091506d8d7c9add8159535"

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
