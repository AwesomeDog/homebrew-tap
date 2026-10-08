class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.3/soma-mac-arm64"
      sha256 "247db793a6f006a36580062e696ccfc30b1923a97a3d1b6b87fbc8c00b8e332c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.3/soma-linux-x64"
      sha256 "65203f0e27f8212d79298f21857504fe64c09c727057d93b462152166f0eaa21"
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
