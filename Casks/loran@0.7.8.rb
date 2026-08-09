cask "loran@0.7.8" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.8"
  sha256 arm:   "2dc48b427b348f14f2bf61a95480c59b1374603203a225e461b624f94e893ff8",
         intel: "0796eaafa462b3ce6233ff8645fe39b53b9c95a9f3db29595e1dbe28cbed82b9"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.8/loran-macosx-#{arch}-#{version}.dmg"
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
