cask "loran@0.7.4" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.4"
  sha256 arm:   "1304292c951085bc052203267b759a99560de3b0a345da33ef59188c15da0ddd",
         intel: "143b189c2e6d3a2bab2a4d636c8d33fabff03d97045b40d154e83a70fac0c270"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.4/loran-macosx-#{arch}-#{version}.dmg"
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
