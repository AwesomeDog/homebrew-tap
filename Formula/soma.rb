class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  url "https://github.com/AwesomeDog/soma/releases/download/v0.9.4/soma-mac-arm64"
  sha256 "39fba415847080d0a17531d5e396a9ffdf8c0999b57c6b4438a8a92a6c351993"
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
