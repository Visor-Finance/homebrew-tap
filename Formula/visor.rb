class Visor < Formula
  desc "Command-line interface for the Visor personal API"
  homepage "https://docs.visorfinance.app"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.2.0/visor-aarch64-apple-darwin.tar.xz"
      sha256 "47ca822eadafb573cd359e16cc2a71f4b2c35e541514736d86b976527eb829b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.2.0/visor-x86_64-apple-darwin.tar.xz"
      sha256 "d204cb8a0217ed185f9ba9773c2d3d809f795e78ff3b53f8f81d9e5ee66c2051"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.2.0/visor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ddc8763e8dbf5e87a12f70a1479fb78590835af5b9727260f51ceb7f37db127"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.2.0/visor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1ba3d71309e1dd4556f40e1114fdc27a4f3457ef5252e82d9b1b8e4a9eef2895"
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
