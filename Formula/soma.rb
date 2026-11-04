class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.8/soma-mac-arm64"
      sha256 "ea5537abd6d8773a999ce85215b3b3da047d58b9ceb713ff1c9963b032d8721e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/soma/releases/download/v0.10.8/soma-linux-x64"
      sha256 "e6e3ec7dea28a9e3f05111a780816ebe17c25e91ba6a16305cb7542e618fc486"
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
