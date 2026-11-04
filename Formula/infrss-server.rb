class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.8/infrss-server-macos-arm64"
      sha256 "e48508f605e72b7bbbaa9dfcdb321438a59ed89de3df630d4e136e94e8b380f5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.8/infrss-server-linux-amd64"
      sha256 "3ae6f227a3ed91bdc81b0e6dbf41ba60e336bea1fae975a13c3686912e97ad5f"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
