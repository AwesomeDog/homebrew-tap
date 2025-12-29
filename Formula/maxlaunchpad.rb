# Formula/maxlaunchpad.rb
class Maxlaunchpad < Formula
  desc "A simple, reliable launcher that makes your most-used applications instantly accessible from the keyboard"
  homepage "https://github.com/AwesomeDog/maxlaunchpad"
  url "https://github.com/AwesomeDog/maxlaunchpad/releases/download/v1.0.3/MaxLaunchpad.dmg"
  sha256 "04de40782d4dabed2b5930bd82175a1004657033f014f2a7ec1611dcbb0e8ac9"
  version "1.0.3"
  app "MaxLaunchpad.app"

  # Support macOS 12+ (Monterey, Ventura, Sonoma, Tahoe) - expand to :monterey for broader compatibility
  depends_on :macos => :monterey

  # Core: Skip quarantine flag during download (avoid "unverified developer" issue)
  def download
    downloader = self.class::CurlDownloader.new(url, mirror_url, sha256, version: version)
    downloader.curl_args += ["--no-quarantine"] # Bypass com.apple.quarantine attribute
    downloader.fetch
  end

  def install
    # Step 1: Mount DMG image (read-only, no browser popup)
    dmg_path = Pathname.new(downloader.cached_location)
    mount_output = `/usr/bin/hdiutil attach -nobrowse -readonly -quiet "#{dmg_path}" 2>&1`
    mount_point = mount_output.split("\t").last.chomp
    raise "DMG mount failed! Output: #{mount_output}" if mount_point.empty?

    # Step 2: Verify App exists in DMG
    app_source = Pathname.new(mount_point)/"#{app}"
    unless app_source.exist?
      system "/usr/bin/hdiutil detach -quiet #{mount_point}" # Cleanup mount on failure
      raise "#{app} not found in DMG! Check the exact filename (case-sensitive)."
    end

    # Step 3: Copy App to /Applications (overwrite old version if exists)
    app_dest = Pathname.new("/Applications")/"#{app}"
    if app_dest.exist?
      system "rm", "-rf", app_dest
      opoo "Removed existing #{app} from /Applications (old version)"
    end
    system "cp", "-R", app_source, app_dest
    raise "Failed to copy #{app} to /Applications!" unless app_dest.exist?

    # Step 4: Fallback quarantine cleanup (redundant but safe)
    xattr_cmd = "xattr -cr #{app_dest}"
    xattr_output = `#{xattr_cmd} 2>&1`
    opoo "Fallback quarantine cleanup: #{xattr_output}" unless $?.success?

    # Step 5: Add login item (auto-switch: loginitemutil for 14+/plist for legacy)
    add_login_item(app_dest)

    # Step 6: Unmount DMG image (silent cleanup)
    system "/usr/bin/hdiutil detach -quiet #{mount_point}"
  end

  # Encapsulated: Add login item (compatible with legacy macOS + Tahoe/Sonoma)
  def add_login_item(app_path)
    # Unique identifier for login item (avoid duplicates)
    login_item_id = "com.awesomedog.maxlaunchpad"
    
    # Cleanup existing login items first (prevent duplicates)
    system "loginitemutil remove #{login_item_id} 2>&1" # Cleanup Sonoma/Tahoe
    system "launchctl unload ~/Library/LaunchAgents/#{login_item_id}.plist 2>&1" # Cleanup legacy
    system "rm -f ~/Library/LaunchAgents/#{login_item_id}.plist 2>&1" # Remove old plist

    # Case 1: macOS 14+ (Sonoma/Tahoe) - use official loginitemutil (GUI visible)
    if MacOS.version >= :sonoma
      login_cmd = <<~BASH
        loginitemutil add \
          --id #{login_item_id} \
          --name "MaxLaunchpad" \
          --path "#{app_path}" \
          --hidden false \
          --legacy false
      BASH
      login_output = `#{login_cmd} 2>&1`
      raise "Failed to add Sonoma/Tahoe login item! Output: #{login_output}" unless $?.success?
      opoo "Added MaxLaunchpad to login items (System Settings → General → Login Items)!"

    # Case 2: Legacy macOS (12-13: Monterey/Ventura) - use LaunchAgents plist
    else
      # Create LaunchAgents directory if missing
      plist_dir = Pathname.new(ENV["HOME"])/"Library/LaunchAgents"
      plist_dir.mkpath unless plist_dir.exist?
      plist_path = plist_dir/"#{login_item_id}.plist"

      # Generate standard plist for legacy login items
      plist_content = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{login_item_id}</string>
          <key>ProgramArguments</key>
          <array>
            <string>open</string>
            <string>-a</string>
            <string>#{app_path}</string>
          </array>
          <key>RunAtLoad</key>
          <true/> <!-- Launch on login -->
          <key>KeepAlive</key>
          <false/> <!-- Do not restart if app is closed -->
          <key>LaunchOnlyOnce</key>
          <true/> <!-- Launch only once per login -->
          <key>ExitTimeOut</key>
          <integer>5</integer> <!-- Graceful exit timeout -->
        </dict>
        </plist>
      XML

      # Write plist file and load it
      plist_path.write(plist_content)
      raise "Failed to write legacy plist file!" unless plist_path.exist?
      
      system "launchctl load -w #{plist_path} 2>&1"
      opoo "Failed to load legacy plist (may already exist): #{$?}" unless $?.success?
      opoo "Added MaxLaunchpad to login items (System Settings → Users & Groups → Login Items)!"
    end
  end

  # Test validation (ensure installation integrity for all macOS versions)
  test do
    app_dest = Pathname.new("/Applications")/"#{app}"
    assert_predicate app_dest, :exist?, "#{app} not installed to /Applications!"
    
    login_item_id = "com.awesomedog.maxlaunchpad"
    # Verify login item (Sonoma/Tahoe)
    if MacOS.version >= :sonoma
      login_item_check = `loginitemutil list | grep #{login_item_id} 2>&1`
      assert_match login_item_id, login_item_check, "Sonoma/Tahoe login item not added!"
    # Verify plist (legacy macOS)
    else
      plist_path = Pathname.new(ENV["HOME"])/"Library/LaunchAgents/#{login_item_id}.plist"
      assert_predicate plist_path, :exist?, "Legacy plist login item not created!"
    end

    # Verify no quarantine attribute
    quarantine_attr = `xattr -p com.apple.quarantine #{app_dest} 2>&1`
    assert_match "No such xattr: com.apple.quarantine", quarantine_attr, "Application still quarantined!"
  end

  # Post-installation instructions (version-specific)
  def caveats
    login_item_id = "com.awesomedog.maxlaunchpad"
    if MacOS.version >= :sonoma
      instructions = <<~EOS
        ✅ MaxLaunchpad installed successfully (macOS Sonoma/Tahoe)!
        
        Launch application:
          open /Applications/#{app}
        
        Manage login items:
          - System Settings → General → Login Items (MaxLaunchpad visible)
          - Manual removal: loginitemutil remove #{login_item_id}
        
        Update application:
          brew upgrade AwesomeDog/tap/maxlaunchpad
      EOS
    else
      instructions = <<~EOS
        ✅ MaxLaunchpad installed successfully (legacy macOS)!
        
        Launch application:
          open /Applications/#{app}
        
        Manage login items:
          - System Settings → Users & Groups → Login Items (MaxLaunchpad visible)
          - Manual removal: launchctl unload ~/Library/LaunchAgents/#{login_item_id}.plist && rm -f $_
        
        Update application:
          brew upgrade AwesomeDog/tap/maxlaunchpad
      EOS
    end
    return instructions
  end

  # Uninstall cleanup (supports all macOS versions)
  def uninstall
    login_item_id = "com.awesomedog.maxlaunchpad"
    
    # Cleanup Sonoma/Tahoe login item
    system "loginitemutil remove #{login_item_id} 2>&1"
    
    # Cleanup legacy plist/login item
    system "launchctl unload ~/Library/LaunchAgents/#{login_item_id}.plist 2>&1"
    system "rm -f ~/Library/LaunchAgents/#{login_item_id}.plist 2>&1"
    
    # Remove application from /Applications
    app_dest = Pathname.new("/Applications")/"#{app}"
    system "rm", "-rf", app_dest if app_dest.exist?
    
    opoo "Uninstalled MaxLaunchpad and removed login item completely!"
  end
end