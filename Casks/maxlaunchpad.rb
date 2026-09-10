cask "maxlaunchpad" do
  version "1.1.1"
  sha256 "01ca4c831447b8cf1b50dc2f19478acc85f05d5e305aa41841ae9724024dd8d5"

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
