class Infrss < Formula
  desc "Infinite-scrolling RSS reader for Thunderbird"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  version "2.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v#{version}/infrss-macos-arm64"
      sha256 "9a757090ea02592d70a912d89a3abd7a575fd2d1851759f27ba022747057eb23"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v#{version}/infrss-linux-amd64"
      sha256 "2da0a7d5bac22a8c1f0f8d9bb0b687e6f3c3c0dd7156559128660af581655fc1"
    end
  end

  def install
    binary_name = "infrss"
    # The download is a raw binary (not an archive), rename and install it
    bin.install Dir.glob("infrss-*").first => binary_name
  end

  def post_install
    system bin/"infrss", "--install"
  end

  test do
    assert_match "infrss", shell_output("#{Dir.home}/.local/bin/infrss --version")
  end
end
