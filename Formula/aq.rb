class Aq < Formula
  desc "Command-line tool to extend jq for any format"
  homepage "https://github.com/rossmacarthur/aq"
  url "https://github.com/rossmacarthur/aq/archive/refs/tags/0.3.0.tar.gz"
  sha256 "7a3c3a9a6813c0dce3b3dd2dbaeed431cac20f5cb880b5010eec868db8ec8bb4"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/aq.git", branch: "trunk"

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/aq-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "29c01120ccee5cb2ee541e6ad3354f00a32e29f58d9fdde9e9dab2d0d34c251e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "277f5185da14b404f3077eb43a8972e7f501e995fd278e9569b3db620dca5084"
    sha256 cellar: :any_skip_relocation, ventura:       "1c156d29f8f9ecd8b4463f1661fef0ac71efb0348377eb26d6640d29a4569fa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa9f9153394f8ec501ef8a8956cd25bab276c9b3e379f7612c3335114bb0608c"
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
