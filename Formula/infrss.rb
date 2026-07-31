class Infrss < Formula
  desc "Infinite-scrolling RSS reader for Thunderbird"
  homepage "https://awesomedog.github.io/infinite-rss-reader/"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.1/infrss-macos-arm64"
      sha256 "6cb7bbb754ccd4734442fb3882ed933aa8349426318781c8e0df17b6528888df"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AwesomeDog/infinite-rss-reader/releases/download/v2.1.1/infrss-linux-amd64"
      sha256 "62eff215ebb616912c6d28d9cd035c39ccf014c55010bac427e3e94c00e87b6c"
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
