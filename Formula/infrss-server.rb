class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.2.0/infrss-server-macos-arm64"
      sha256 "278e6711f73b483885b2cd20405c384f755313cda8c61bb54520465a527844b8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.2.0/infrss-server-linux-amd64"
      sha256 "b4850c3c7e14ec090ee6f62e61baa4b4d4a2331e8bfa0d935a4e002deebb0eb9"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
