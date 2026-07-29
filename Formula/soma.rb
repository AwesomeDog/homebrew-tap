class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  url "https://github.com/AwesomeDog/soma/releases/download/v0.9.2/soma-mac-arm64"
  sha256 "eab8d5ab10891e8d9cc50df39dbb752c0c86c5f7c6d579a2f6325583b5940392"
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
