class Powerpack < Formula
  desc "Command-line tool to build your Alfred workflows in Rust!"
  homepage "https://github.com/rossmacarthur/powerpack"
  url "https://github.com/rossmacarthur/powerpack/archive/refs/tags/0.8.0.tar.gz"
  sha256 "c68afe4a0c06d4c46a532b8e0a5310dbdd01af5d4286a02f8e031010ff109758"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/powerpack.git", branch: "trunk"

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
