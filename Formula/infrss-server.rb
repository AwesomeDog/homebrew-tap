class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.4/infrss-server-macos-arm64"
      sha256 "f62f8ae8f8e4f128afdd02f54c2e93b874dee6e4ade8e108b915e84cdf860d02"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.4/infrss-server-linux-amd64"
      sha256 "c9bbc1f293764971962ce4f8240766200ca3a89a880fac375cd066de071a3652"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
