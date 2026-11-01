cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.9.0"
  sha256 arm:   "d061b63b0c3c6dc18e6eff3d3ea53204291c4cd7fbeb5b6710797626e95f641d",
         intel: "23eae4da67027241ccf6b5140d084c482d3ebe2629dddaf3bc237c5b0ea1dedd"

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
