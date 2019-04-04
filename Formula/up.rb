class Up < Formula
  desc "Tool for working with Docker locally"
  homepage "http://github.com/paulcsmith/up"
  url "https://github.com/paulcsmith/up/raw/master/tarballs/up-0.1.0.tar.gz"
  sha256 "1a5e8138f71269626d2f68c614ca9f5ef5593fb9951697f19b4aac6b6bca0e94"
  version "0.1.0"
  depends_on "crystal-lang"

  def install
    system "mkdir lib"
    system "ls"
    system "crystal build lib/lucky_cli/src/lucky.cr"
    bin.install "up"
  end

  test do
    system "{bin}/up", "--help"
  end
end
