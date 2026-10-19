cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.29"
  sha256 arm:   "9c7c2e957e9d2958f7df5ce36112b389cb32734e27f7587ac322f43b58d35f68",
         intel: "dd78cb97585e95f034cd0883324da0f1332c5ca25c0fa44d1d283cafa01ed3e3"

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
