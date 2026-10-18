cask "loran" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.28"
  sha256 arm:   "2bd5d438487b9663cfa68aed75853d5e0e58c7b40bf6206c241cce054937d38b",
         intel: "861c7fcde54a513c3dfd54323cdd0ff8203a983e39a67179083c80313c85d039"

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
