class LeanCli < Formula
  desc "Command-line tool to develop and manage LeanCloud apps."
  homepage "https://github.com/leancloud/lean-cli"
  url "https://github.com/leancloud/lean-cli/archive/v0.7.2.tar.gz"
  sha256 "6869554bcd956e1a6c107b63bd7ed17b872bf0fd688151cb83a1f26d87e5c4c4"
  head "https://github.com/leancloud/lean-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d0392b5d316cb440a701f2cb70551458c989c462b89752a03f01fb245c7c1eab" => :sierra
    sha256 "7e17f1058593b4b515481fa57103a4c5ce46cc1d1e1968e39ef17dc1b1bd5575" => :el_capitan
    sha256 "06722227c529968881fe7e8ff3de70fcfb5a93726ca02cbc9d5630415cd13ba6" => :yosemite
  end

  depends_on "go" => :build

  def install
    build_from = build.head? ? "homebrew-head" : "homebrew"
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/leancloud/"
    ln_s buildpath, buildpath/"src/github.com/leancloud/lean-cli"
    system "go", "build", "-o", bin/"lean",
                 "-ldflags", "-X main.pkgType=#{build_from}",
                 "github.com/leancloud/lean-cli/lean"
  end

  test do
    assert_match "lean version #{version}", shell_output("#{bin}/lean --version")
  end
end
