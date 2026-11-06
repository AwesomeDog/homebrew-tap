class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.9/infrss-server-macos-arm64"
      sha256 "e08bffe9d73e4ebedf767b5b8def0651d8aa3b4dc78407decbf0b86b58a4335e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.9/infrss-server-linux-amd64"
      sha256 "eb2414880dc0ff1da6b8274ede176afdd07279232fc601edf211ee1eaa92cc13"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
