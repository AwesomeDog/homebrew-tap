class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.5/soma-mac-arm64"
      sha256 "b94eec114af5a71b65489a3f9de3420896cd871ede1c3e84c362e1e872b30485"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.5/soma-linux-x64"
      sha256 "21f8ef2e2c9fe20a9899001cf4fde40f10687cf08307dfd69a66e1085eea80e6"
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
