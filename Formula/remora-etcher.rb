class RemoraEtcher < Formula
  desc "Standalone provisioning and flashing tool for Remora devices"
  homepage "https://github.com/sntns/remora-companion"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.4.1/remora-etcher-aarch64-apple-darwin.tar.xz"
      sha256 "0087762abef8d7d4e5c6d33bd7c69ec4f1345b10d03cebae184e390e53d8c8e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.4.1/remora-etcher-x86_64-apple-darwin.tar.xz"
      sha256 "1d80d029d854578d85d30d07df32ca95ae7d1f1e48fd5a831d34c9ea240cb6e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.4.1/remora-etcher-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9beefdd798b458db2332ac3ac1d7f3c23518237dacad16186654926614764352"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.4.1/remora-etcher-x86_64-unknown-linux-musl.tar.xz"
      sha256 "63afe126a194a73e7225bfa8338cb25ba0b9de1020311880bccfb1448a8786c8"
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
