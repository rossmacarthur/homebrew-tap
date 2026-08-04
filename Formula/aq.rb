class Aq < Formula
  desc "Command-line tool to extend jq for any format"
  homepage "https://github.com/rossmacarthur/aq"
  url "https://github.com/rossmacarthur/aq/archive/refs/tags/0.6.0.tar.gz"
  sha256 "7ea60f73f9e21e6293dd3a6c4823511ed036156e31f20ec68d18d0ea84061557"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/aq.git", branch: "trunk"

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/aq-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7b33481fc21515ce596d248e6ab9f24bef8ac4fd022823ce02d0479206afbd5e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e74d26b4a314632269a4f0417a026f55d923716c5f162981d3f623af092c24d5"
    sha256 cellar: :any,                 x86_64_linux: "cc89fef71017527a15af22c166fe21b1553a56de2be5bb637a8b654a25b33363"
  end

  depends_on "rust" => :build
  depends_on "jq"

  def install
    system "cargo", "install", *std_cargo_args
    bin.install_symlink bin/"aq" => "yq"
    bin.install_symlink bin/"aq" => "tq"
  end

  test do
    output = pipe_output("#{bin}/aq --input json --output toml .", '{"foo": 1337}')
    assert_match "foo = 1337", output
  end
end
