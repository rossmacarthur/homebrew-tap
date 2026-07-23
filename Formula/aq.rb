class Aq < Formula
  desc "Command-line tool to extend jq for any format"
  homepage "https://github.com/rossmacarthur/aq"
  url "https://github.com/rossmacarthur/aq/archive/refs/tags/0.5.0.tar.gz"
  sha256 "86e01bce8e272ad70b7069dcf43b517b80f12470841b7de4357fb15440399795"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/aq.git", branch: "trunk"

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/aq-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ab9c59c6bfe2fe835fe4d747c1d0fda6ae6bb75a2b9315f526abe54d8953287a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "fc5b28e944ab36130107dad63ab2917ce90a1b379a47a59ace1ef92dfb9eb2a0"
    sha256 cellar: :any,                 x86_64_linux: "1181b6595de9db5f51b5fbcc9b1cfe588f2fcbd7589fade8aa7ab6beb1fc99a1"
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
