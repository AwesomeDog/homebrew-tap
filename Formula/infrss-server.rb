class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.2/infrss-server-macos-arm64"
      sha256 "7dcf5f46a9c6706a78892c9fe2bdadd0d4ed4ce69f2111a65186399ba68a7469"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.2/infrss-server-linux-amd64"
      sha256 "cf237c065e44db1de10970528677f2578adcb24d2753711ea5bc7fadcff34368"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
