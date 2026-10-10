class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.4/soma-mac-arm64"
      sha256 "a3f98cd0f948437bd842c7c5b5985c61b7498c686802431cd42ec780d3e3abbd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.4/soma-linux-x64"
      sha256 "838a9c4444835a6ff796ca46e349093ef0a316476fbee8fa13a7f93699cddb7f"
    end
  end

  def install
    # The download is a raw binary (not an archive), rename and install it
    bin.install Dir.glob("soma-*").first => "soma"

    return unless OS.mac?

    # macOS quarantines downloaded binaries, which triggers a Gatekeeper prompt
    # on first run. Clear the flag right after install.
    attributes = Utils.safe_popen_read("/usr/bin/xattr", bin/"soma").lines(chomp: true)
    system "/usr/bin/xattr", "-d", "com.apple.quarantine", bin/"soma" if attributes.include?("com.apple.quarantine")
  end

  test do
    assert_match "soma #{version}", shell_output("#{bin}/soma --version")
  end
end
