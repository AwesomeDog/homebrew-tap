class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.6/infrss-server-macos-arm64"
      sha256 "d23afe3e88dcf6664238ea80000cdd25ef33222a075d66870f2ea99dcac8581a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.6/infrss-server-linux-amd64"
      sha256 "215903c34069609c24574b0cdd619f2ed5d96e1364f54c6304d3088b985b5244"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
