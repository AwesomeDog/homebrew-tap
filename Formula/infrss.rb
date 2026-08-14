class Infrss < Formula
  desc "Infinite-scrolling RSS reader for Thunderbird"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.3/infrss-macos-arm64"
      sha256 "355c5939405c2f61e9215c6e07c0243fdac8cae5ab7ea232216cf6e0efd757aa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.3/infrss-linux-amd64"
      sha256 "73b70829d344f189a3f6f1a2ba30331f96b18557112b2caa2e9ec543d6a9df09"
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
