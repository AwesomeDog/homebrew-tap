class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  url "https://github.com/AwesomeDog/soma/releases/download/v0.9.1/soma-mac-arm64"
  version "0.9.1"
  sha256 "4087a800ed2a4cbaf91e8c9ec3642c22eb5d700b0fb95d4727e73b8912e39ad8"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "soma-mac-arm64" => "soma"

    attributes = Utils.safe_popen_read("/usr/bin/xattr", bin/"soma").lines(chomp: true)
    system "/usr/bin/xattr", "-d", "com.apple.quarantine", bin/"soma" if attributes.include?("com.apple.quarantine")
  end

  test do
    assert_match "soma #{version}", shell_output("#{bin}/soma --version")
  end
end
