class Aq < Formula
  desc "Command-line tool to extend jq for any format"
  homepage "https://github.com/rossmacarthur/aq"
  url "https://github.com/rossmacarthur/aq/archive/refs/tags/0.5.0.tar.gz"
  sha256 "86e01bce8e272ad70b7069dcf43b517b80f12470841b7de4357fb15440399795"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/aq.git", branch: "trunk"

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/aq-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9c327e41329f2db0d1dad91b3fb8eda4fbfc051c7d6d3f8d1d2ef4ed188ace41"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1622885c646a8fc85976d7387519200593d5abfa8bfd8bf38dd34fec0be81791"
    sha256 cellar: :any,                 x86_64_linux: "dbfe15028a6849fbdb8c33279fb8f46be7127e3a76a980646e36e2a09bc83f18"
  end

  depends_on "rust" => :build
  depends_on "jq"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = pipe_output("#{bin}/aq --input json --output toml .", '{"foo": 1337}')
    assert_match "foo = 1337", output
  end
end
