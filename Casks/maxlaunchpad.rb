cask "maxlaunchpad" do
  version "1.1.0"
  sha256 "3d23f12e80f5e080dc6b97005f2a495b8069df8289bec22d444e9dd22a442734"

  url "https://github.com/AwesomeDog/maxlaunchpad/releases/download/v#{version}/MaxLaunchpad.dmg"
  name "MaxLaunchpad"
  desc "A simple, reliable launcher that makes your most-used applications instantly accessible from the keyboard"
  homepage "https://github.com/AwesomeDog/maxlaunchpad"

  depends_on macos: :monterey

  app "MaxLaunchpad.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "/Applications/MaxLaunchpad.app"]
  end

  uninstall quit: "com.awesomedog.maxlaunchpad"

  zap trash: [
    "~/Library/Preferences/com.awesomedog.maxlaunchpad.plist",
    "~/Library/Application Support/MaxLaunchpad",
    "~/Library/Caches/com.awesomedog.maxlaunchpad",
    "~/Library/LaunchAgents/com.awesomedog.maxlaunchpad.plist",
  ]

  caveats <<~EOS
    To have MaxLaunchpad start on Startup, open the app and enable
    "Launch on Startup" in its settings, or manually add it via:
      System Settings → General → Login Items
  EOS
end
