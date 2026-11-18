class RemoraEtcher < Formula
  desc "Standalone provisioning and flashing tool for Remora devices"
  homepage "https://github.com/sntns/remora-companion"
  version "0.25.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.4/remora-etcher-aarch64-apple-darwin.tar.xz"
      sha256 "de0377acc537083f13288207500fffdcf75966ba0c44769ea1302ea2da3f5a71"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.4/remora-etcher-x86_64-apple-darwin.tar.xz"
      sha256 "243efe0c6e6e4b5f7893ac3b01fe3533e4c83e5084b5f102843e25a7f4c21079"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.4/remora-etcher-aarch64-unknown-linux-musl.tar.xz"
      sha256 "97d8a5d0d3267555bdbb82f84be57e87bbb84b2ca697955cb9a61a2ec8aa377a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.25.4/remora-etcher-x86_64-unknown-linux-musl.tar.xz"
      sha256 "31b3802247e19b1046c6ed09f8d0271504504bd577441e581cfef9d1f8f8cdd9"
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
