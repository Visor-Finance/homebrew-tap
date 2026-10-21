class Visor < Formula
  desc "Command-line interface for the Visor personal API"
  homepage "https://docs.visorfinance.app"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.1.0/visor-aarch64-apple-darwin.tar.xz"
      sha256 "5e4963f3e373fe23dbd6f8116871fbaa7d0730863d42e3661680e49575039524"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.1.0/visor-x86_64-apple-darwin.tar.xz"
      sha256 "5250c4e27e711a7ae7d91d6456ff136a45a73f3ae15e4c2d9c4db95e0c57ea84"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.1.0/visor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a865e7e022fbd682aefb19578de76b2354df58220a78fe8ed5d752d6f3be6384"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.1.0/visor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a759a21ee1985e00bad897727d434512a473c04b5c67541bc6ae569eb36c875"
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
