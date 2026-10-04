class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.5/infrss-server-macos-arm64"
      sha256 "eba559f818bbcde56b250d9ee5a4c116449d1aef3d5dba0f0583a3e4b5ac6b4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.5/infrss-server-linux-amd64"
      sha256 "430a34df35115b5a0a0c09267c46a3a4eb446338a3faeae66ae1cded12b53b0a"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
