cask "loran@0.8.26" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.26"
  sha256 arm:   "e50d021430ca379a1e417e3bc067d9a829e092868c29c497dc147ff6371422db",
         intel: "9e03153d218119b7ea3a06ba36538d5e0a9152be61981995a24d853645fcc547"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.26/loran-macosx-#{arch}-#{version}.dmg"
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
