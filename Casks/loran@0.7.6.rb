cask "loran@0.7.6" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.6"
  sha256 arm:   "3a1390c6a4baf31cb7bca92ac48d59dad51ea7b30c1b17fd7b20ea7095d4e512",
         intel: "2e48242abf8032ab879ed08e0f32ae87e1a0fd86e71004a5b74ccc0cfbd5c239"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.6/loran-macosx-#{arch}-#{version}.dmg"
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
