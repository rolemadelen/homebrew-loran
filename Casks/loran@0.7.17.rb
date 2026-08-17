cask "loran@0.7.17" do
  arch arm: "aarch64", intel: "intel"

  version "0.7.17"
  sha256 arm:   "44ad358cf37d139582eb63563c59af95bd4f4d1d8e8d8d9cdee355773f6016e1",
         intel: "279a4bbea0279a052a6f2708be1eed5137073eaff2370cd27ec6483454f594f6"

  url "https://gitlab.com/jiiyoo17/loran-releases/-/raw/main/releases/v0.7.17/loran-macosx-#{arch}-#{version}.dmg"
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
