# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "watchexec"
  depends_on "candid82/brew/joker"
  # depends_on "https://raw.githubusercontent.com/candid82/homebrew-brew/2491ed79f9733e6d58b41eef0a771659a0eed162/joker.rb"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.6.0/goku.zip"
  sha256 "f07748c2da7347a3b65826cc60827a3c770cdbb5e66fee137391668e5d1d0014"

  def install
    bin.install "goku"
    bin.install "gokuw"
  end

  service do
    run ["/bin/zsh", "-c", "exec -a gokuw #{Formula["watchexec"].opt_bin}/watchexec --restart -e edn --watch #{ENV["HOME"]}/.config/karabiner.edn #{opt_bin}/goku"]
    keep_alive true
    process_type :interactive
    log_path "#{ENV["HOME"]}/Library/Logs/goku/goku.out.log"
    error_log_path "#{ENV["HOME"]}/Library/Logs/goku/goku.err.log"
  end

  test do
    system "#{bin}/goku", "--help"
  end
end
