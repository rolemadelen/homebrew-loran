cask "loran@0.8.29" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.29"
  sha256 arm:   "f1f09aab4a4abde7c987a028f5faa5fc012d7dcb93015bac55d15870c9aba003",
         intel: "47467ada3f5f016c583eb848e2d66a924c3d0cb100741b5413dc037896bddb3c"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.29/loran-macosx-#{arch}-#{version}.dmg"
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
