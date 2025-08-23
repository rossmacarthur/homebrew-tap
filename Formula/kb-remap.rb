class KbRemap < Formula
  desc "Command-line tool to remap macOS keyboard keys"
  homepage "https://github.com/rossmacarthur/kb-remap"
  url "https://github.com/rossmacarthur/kb-remap/archive/refs/tags/0.4.1.tar.gz"
  sha256 "2d062cbc1e0a9aeb336cf0ed524a4b8c9a79c89538253f002d309cddb82c6954"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/kb-remap.git", branch: "trunk"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args

    bash_completion.install "completions/kb-remap.bash" => "kb-remap"
    zsh_completion.install "completions/kb-remap.zsh" => "_kb-remap"
  end

  test do
    assert_includes shell_output("#{bin}/kb-remap --map a:b --dump"), "hidutil property"
  end
end
