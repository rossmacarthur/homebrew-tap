class KbRemap < Formula
  desc "Command-line tool to remap macOS keyboard keys"
  homepage "https://github.com/rossmacarthur/kb-remap"
  url "https://github.com/rossmacarthur/kb-remap/archive/refs/tags/0.5.0.tar.gz"
  sha256 "ad24a23f3c49ab8e312ea69e9b71a02b05fc9a018e1a8592d99c4ba5158449d1"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/rossmacarthur/kb-remap.git", branch: "trunk"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/kb-remap-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "07b6410e0de90e68bd65c029cdac915aecd1838005283226808abdff9cb279d7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "49b77f7a46e2297014b5b33abda66461beb9982bc90866edfdc7b356499f3517"
    sha256 cellar: :any_skip_relocation, ventura:       "b6e252bacf2c87faf87c596360b1e037431560790648a4e28560450fa444c184"
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
