class Eyesonly < Formula
  desc "Per-user access control for git: private files, private branches, built-in secrets"
  homepage "https://jagritvats.github.io/eyesonly/"
  url "https://registry.npmjs.org/eyesonly/-/eyesonly-0.3.1.tgz"
  sha256 "5481d137ca534a6639bc05cf3e39d08e415c089606d92e418049b3ad9f3955b2"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/eyesonly --version")
    system "git", "init", testpath/"r"
    # functional check: keygen creates an identity and prints a public card
    ENV["EYESONLY_HOME"] = testpath/"h"
    assert_match "eyesonlypub1:", shell_output("#{bin}/eyesonly keygen tester 2>&1")
  end
end
