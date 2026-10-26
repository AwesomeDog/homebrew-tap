class Infrss < Formula
  desc "Infinite-scrolling RSS reader for Thunderbird"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.7/infrss-macos-arm64"
      sha256 "4b9a71f70633bc26c15fc857973811d79ae2bc2f86700881ce5c9938163688ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.7/infrss-linux-amd64"
      sha256 "d11f196cd1db6885c3530034bafc1d8b3dc1fc877122bfc2cd5b1a1445521e80"
    end
  end

  def install
    binary_name = "infrss"
    # The download is a raw binary (not an archive), rename and install it
    bin.install Dir.glob("infrss-*").first => binary_name
  end

  # Homebrew's sandbox blocks writes to $HOME in post_install.
  # The user must run the setup command manually after install.
  def caveats
    <<~EOS
      To complete the setup (install Thunderbird extension + native messaging manifest), run:
        infrss
    EOS
  end

  test do
    assert_match "infrss v#{version}", shell_output("#{bin}/infrss --version")
  end
end
