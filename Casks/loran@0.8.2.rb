cask "loran@0.8.2" do
  arch arm: "aarch64", intel: "intel"

  version "0.8.2"
  sha256 arm:   "20df0f3f3828ea7a189247efd825f5f7fe18c33a20843f6b9bf4e8168e8efd3d",
         intel: "93c54179e74146ef4561fe59e591e82bc6233d1571f66ffb186c66ed5b17534c"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.8.2/loran-macosx-#{arch}-#{version}.dmg"
  name "Loran"
  desc "Markdown note-taking app"
  homepage "https://loran.day/"

  # Same app name/bundle as the main cask — only one can be installed at a time
  conflicts_with cask: "loran"
  depends_on :macos

  app "loran.app"

  postflight do
    # Loran isn't Apple-notarized yet, so the quarantine flag set on
    # download would otherwise trigger Gatekeeper's "Apple could not
    # verify..." dialog on first launch. Stripping it here means brew
    # install is the only step a user needs - no right-click-Open dance.
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{appdir}/loran.app"],
                   sudo: false
  end
end
