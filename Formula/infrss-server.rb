class InfrssServer < Formula
  desc "Server for Infinite RSS Reader"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.3/infrss-server-macos-arm64"
      sha256 "890b792df6934e703db9173c8ce73adb100a18103bc755235e8a3b255ecab1e8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.3/infrss-server-linux-amd64"
      sha256 "ed1639fc3e7d0704446dc0ab83442dff1bea72f1160f6553dce35e2c21573a4f"
    end
  end

  def install
    bin.install Dir.glob("infrss-server-*").first => "infrss-server"
  end

  test do
    assert_match "infrss-server v#{version}", shell_output("#{bin}/infrss-server --version")
  end
end
