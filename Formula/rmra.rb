class Rmra < Formula
  desc "Remora operator CLI: log in to sntns-platform and reach your devices through the remora channel"
  homepage "https://github.com/sntns/remora-companion"
  version "0.25.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.0/rmra-aarch64-apple-darwin.tar.xz"
      sha256 "50ad2dab3f22c0a6339cfd08e672cbec8b5fd914883e0a30b33404bd55c4c973"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.0/rmra-x86_64-apple-darwin.tar.xz"
      sha256 "4e3103326ac3553c97f431652437867ddda2c73b4eb2c431b9ecb960e265a9c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.0/rmra-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a7c8d8987c30934969e931a0e8902fe6676960a9ba57af7c390ff1fc23820ac7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.0/rmra-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9cd977109dd9fe9c6d3443e93e100a5796657aede2c70c487811fdecd757eab0"
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
