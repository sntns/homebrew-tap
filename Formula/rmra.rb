class Rmra < Formula
  desc "Remora operator CLI: log in to sntns-platform and reach your devices through the remora channel"
  homepage "https://github.com/sntns/remora-companion"
  version "0.24.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.24.0/rmra-aarch64-apple-darwin.tar.xz"
      sha256 "0babc097f8c43c4aa546373667e1b305b95a55a7993610eaa26cd00fe2a0de7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.24.0/rmra-x86_64-apple-darwin.tar.xz"
      sha256 "6a900b199992c967a6b522aa4be33babb175100af483fcb8f004b88baff3077c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.24.0/rmra-aarch64-unknown-linux-musl.tar.xz"
      sha256 "bc82a87c11eee49dcf7ffe151dbf07004428982e8b7f82c1f3c98bb47abda03b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.24.0/rmra-x86_64-unknown-linux-musl.tar.xz"
      sha256 "783ee33f0696ed38a29f9459377bdf21ca4e2338d80a052c691cbf29eb98e734"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "rmra"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rmra"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rmra"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rmra"
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
