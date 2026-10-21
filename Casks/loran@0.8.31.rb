cask "loran@0.8.31" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.31"
  sha256 arm:   "4b52a4c4ba97f985bd3cd340f257c98bba7e87ee4f108c834302edee6cb8ff54",
         intel: "4bc56f787705064d7644bc07f006061e05dc242d985e036267d0482e28174381"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.31/loran-macosx-#{arch}-#{version}.dmg"
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
