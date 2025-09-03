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
    root_url "https://github.com/rossmacarthur/homebrew-tap/releases/download/kb-remap-0.4.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ce8e789c96080a4510609dbb7d428f1753ce3d84ce7b7595bcd6a344222c74e8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c8e9050d685777f1147f6f062388635902a214e57e064dd5849e8d746562ded9"
    sha256 cellar: :any_skip_relocation, ventura:       "c17036853936301acf88ed57e31b6786d712a61f304e1a65b8337766f7a3955e"
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
