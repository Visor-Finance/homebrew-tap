class Visor < Formula
  desc "Command-line interface for the Visor personal API"
  homepage "https://docs.visorfinance.app"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.3.0/visor-aarch64-apple-darwin.tar.xz"
      sha256 "706c88cc1ab4ff3ece7e4717b5518460158653f86d7ba47773bda66940456396"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.3.0/visor-x86_64-apple-darwin.tar.xz"
      sha256 "f7f9605c5b99158cc071d428a3ebc9898b6ca688132572474a9fbdeae7959728"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.3.0/visor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "42eec5d9e4c6a4cfe86f3a18d1bff5d31fac83a77cf7baaa823be8f650fef09a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.3.0/visor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2bcd651ae998fe9322cdd4c40817ceaf00f39c46a21328de3677cbb6939a0094"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "visor"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "visor"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "visor"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "visor"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
