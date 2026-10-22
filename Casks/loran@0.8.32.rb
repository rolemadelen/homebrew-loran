cask "loran@0.8.32" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.32"
  sha256 arm:   "9f5281afd0fa9c13db224ae18dd0b596f6421c91513f978192c826dff74339fd",
         intel: "128e115336f06f162f7c19b40f0a86a064cba1c031e50b1a88b7c3786244add6"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.32/loran-macosx-#{arch}-#{version}.dmg"
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
