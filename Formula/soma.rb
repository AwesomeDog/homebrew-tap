class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.2/soma-mac-arm64"
      sha256 "75f4e0bb9242bd5b36d9ed14093cfdda6ff752af89f264833890f0c8f297e02c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.2/soma-linux-x64"
      sha256 "74441e330b4920f5c70555261517b00539ebbf97bef955482c5dfc0b0a082df7"
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
