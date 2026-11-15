class RemoraEtcher < Formula
  desc "Standalone provisioning and flashing tool for Remora devices"
  homepage "https://github.com/sntns/remora-companion"
  version "0.25.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.3/remora-etcher-aarch64-apple-darwin.tar.xz"
      sha256 "217fbf85407a034b8c69044973fc80db66273473a58025e31074e562e1eab8ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.3/remora-etcher-x86_64-apple-darwin.tar.xz"
      sha256 "d61314cdf7e25a32f6d378a13a243b880ba7ebeca1d1b0fff1dae1cdc4814fe5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.3/remora-etcher-aarch64-unknown-linux-musl.tar.xz"
      sha256 "19f242ceac12f4cc7dedd94d54eccbfb801990f1dbef175e89c48ef188c48096"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.3/remora-etcher-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f48d150db663803c4dc31250e68aae3b7e5ed6207bf90e19573f2bd808214fea"
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
      bin.install "remora-etcher"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "remora-etcher"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "remora-etcher"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "remora-etcher"
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
