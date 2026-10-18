cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.28"
  sha256 arm:   "2b231c2f03b3dc23ee0da07fd0fc1abf44b6eec7ddfa68ab7a4e5dd3422178a5",
         intel: "195b0d24673899943c154c80d6e6b059e0492f566110aa979ca3730d97ab6766"

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
