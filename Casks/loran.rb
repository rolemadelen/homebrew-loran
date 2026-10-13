cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.24"
  sha256 arm:   "2222beee6e885466a21c3667766add6b2a83e68eed937719bfdcf801fa908bfe",
         intel: "6c167b124a3a0c30f0de8f170fdf0c4fcc39cf395b4e99312cb5a331ef616b28"

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
