class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.1/infrss-server-macos-arm64"
      sha256 "dd8fa7253dbd70f507b98f1e89a24fa2d97f4059e831afc845f346f79b94ca0a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.1/infrss-server-linux-amd64"
      sha256 "b034ae5229e2a7d547160b6a9343cab02d9cce4b22f4487ea4525af22a4f68b7"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
