class Aq < Formula
  desc "Command-line tool to extend jq for any format"
  homepage "https://github.com/rossmacarthur/aq"
  url "https://github.com/rossmacarthur/aq/archive/refs/tags/0.6.0.tar.gz"
  sha256 "7ea60f73f9e21e6293dd3a6c4823511ed036156e31f20ec68d18d0ea84061557"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/aq.git", branch: "trunk"

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/aq-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "49d74aac4dc5c3fc3ddf17e412e1a7f798e5b325b606f45fdedf5fd1feeeac51"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2352d9e12dfffda89dd5bf77b0bba5ea1b4ea0d2cd529bd9f89d265375684a7b"
    sha256 cellar: :any,                 x86_64_linux: "f552ae6479c818e881bc58d5c791fc9c2586679ef0fc6b749892a9bc2e738d9f"
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
