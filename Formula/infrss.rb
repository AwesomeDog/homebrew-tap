class Infrss < Formula
  desc "Infinite-scrolling RSS reader for Thunderbird"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.4/infrss-macos-arm64"
      sha256 "d7e772373b23a87a3e8ed70beeb3ba8172632d14bd2837fa3602c569291c1f9e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.4/infrss-linux-amd64"
      sha256 "013ea1aa39966cdc71cb705c9bc600ca44af407d560dd8b65cb27d92493262dc"
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
