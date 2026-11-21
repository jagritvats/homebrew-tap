class Eyesonly < Formula
  desc "Per-user access control for git: private files, private branches, built-in secrets"
  homepage "https://jagritvats.github.io/eyesonly/"
  url "https://registry.npmjs.org/eyesonly/-/eyesonly-0.4.0.tgz"
  sha256 "7fce0e0a133fbdd42de22dab6e44612f0d701b4d9654fb9a7c08cdfc7c12b343"
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
