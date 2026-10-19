cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.29"
  sha256 arm:   "26d7dbb0ba387316bb49d88683e5038fbd666c0ad0b0fbce042864c5f3fdcdda",
         intel: "af96c5d45154608cc7b3696185c0981205ed32cd7d90b0cfb47bbf390a28899c"

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
