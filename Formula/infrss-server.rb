class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.7/infrss-server-macos-arm64"
      sha256 "8278dafa33c7b440622ef2d482b49b338ea830efdb5a2eba6935bcb9c1d88645"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.7/infrss-server-linux-amd64"
      sha256 "d7392c79d4fab472525bfee792456be398e7877b36cc0257e2fa4432c9889114"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
