cask "maxlaunchpad" do
  version "1.0.6"
  sha256 "b9ce869a03c8639a2fb76515465a78de28664ef9e637b8264dfdfe0c45b948fe"

  url "https://github.com/AwesomeDog/maxlaunchpad/releases/download/v#{version}/MaxLaunchpad.dmg"
  name "MaxLaunchpad"
  desc "A simple, reliable launcher that makes your most-used applications instantly accessible from the keyboard"
  homepage "https://github.com/AwesomeDog/maxlaunchpad"

  depends_on macos: ">= :monterey"

  app "MaxLaunchpad.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "/Applications/MaxLaunchpad.app"]

    system_command "osascript", args: [
      "-e", 'tell application "System Events" to make login item at end with properties {path:"/Applications/MaxLaunchpad.app", hidden:false}'
    ]
  end

  uninstall quit: "com.awesomedog.maxlaunchpad",
            script: {
              executable: "osascript",
              args: ["-e", 'tell application "System Events" to if exists login item "MaxLaunchpad" then delete login item "MaxLaunchpad"'],
              sudo: false,
            }

  zap trash: [
    "~/Library/Preferences/com.awesomedog.maxlaunchpad.plist",
    "~/Library/Application Support/MaxLaunchpad",
    "~/Library/Caches/com.awesomedog.maxlaunchpad",
    "~/Library/LaunchAgents/com.awesomedog.maxlaunchpad.plist",
  ]

  caveats <<~EOS
    MaxLaunchpad has been added to your login items.

    To manage login items:
      System Settings → General → Login Items
  EOS
end
