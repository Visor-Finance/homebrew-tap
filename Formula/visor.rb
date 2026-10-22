class Visor < Formula
  desc "Command-line interface for the Visor personal API"
  homepage "https://docs.visorfinance.app"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.4.0/visor-aarch64-apple-darwin.tar.xz"
      sha256 "c3e88408cd85e56c16cddf54921bdd122cf48e2135cb565d9bdf4acdbdb54f72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.4.0/visor-x86_64-apple-darwin.tar.xz"
      sha256 "106bbe55dd21c7624751925f227e94c9abd317c26c6c9ce8e990450f5b2815b6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.4.0/visor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "edeac8f2630ab0da75d7e5ff1abd98486fadeac9b7ee41ffe34ce5f526d5261d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Visor-Finance/visor-cli/releases/download/v0.4.0/visor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8f93fdfe9a5ec0b1ae54c3a64447d5b6b120f5879b671b8bbbf8b7333f14be50"
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
