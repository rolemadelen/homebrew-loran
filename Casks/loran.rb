cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.29"
  sha256 arm:   "04bfd6eced53ad5aba26a89fc33df1bb0c898b91b2a9938a9d00c9977ecb2ecb",
         intel: "7b011aeb55fa19a1ef8dea46ab4a896f1259025e33fcff403ed4a5ccf0a52c64"

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
