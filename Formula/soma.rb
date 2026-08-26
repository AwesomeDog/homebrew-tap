class Soma < Formula
  desc "Local knowledge-base search engine for natural-language and keyword search"
  homepage "https://github.com/AwesomeDog/soma"
  url "https://github.com/AwesomeDog/soma/releases/download/v0.10.0/soma-mac-arm64"
  sha256 "9ddc776c7859882741a2172b541960dce39cf6de712ae2b0ea52a79c2cb4ee36"
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
