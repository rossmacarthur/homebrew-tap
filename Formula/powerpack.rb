class Powerpack < Formula
  desc "Command-line tool to build your Alfred workflows in Rust!"
  homepage "https://github.com/rossmacarthur/powerpack"
  url "https://github.com/rossmacarthur/powerpack/archive/refs/tags/0.8.0.tar.gz"
  sha256 "c68afe4a0c06d4c46a532b8e0a5310dbdd01af5d4286a02f8e031010ff109758"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/powerpack.git", branch: "trunk"

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/powerpack-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8ee5c1ec00e487844921b9fe0879612109159ceb0d38874b62ece5690b364d03"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "42e5317a3fd53472f14a76ba0b06e9a4e1aee4c85302ce5cd0cc1e2151a1acd7"
    sha256 cellar: :any_skip_relocation, sequoia:      "8d8b67394957892262bc23d4a7e7bbf5183e7ccdd036df7adb381e9f124e99f5"
    sha256 cellar: :any,                 x86_64_linux: "26877e201c1c410e6c5a66f3c16361aaf07599f2ec4fb55f6a0f7a2fec41fe0f"
  end

  depends_on "rust" => [:build, :test]

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/cli")
  end

  test do
    ENV.prepend_path "PATH", formula_opt_bin("rust")

    input = <<~EOS
      com.example.test
      John Test
      Test description
      test
    EOS
    pipe_output("#{bin}/powerpack new #{testpath}/t --name abcdef", input)

    assert_path_exists testpath/"t"/"Cargo.toml"
    assert_path_exists testpath/"t"/"workflow"/"info.plist"
    assert_path_exists testpath/"t"/"src/main.rs"
  end
end
