class RemoraEtcher < Formula
  desc "Standalone provisioning and flashing tool for Remora devices"
  homepage "https://github.com/sntns/remora-companion"
  version "0.22.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.22.0/remora-etcher-aarch64-apple-darwin.tar.xz"
      sha256 "0606e8e4dad6c2cbbcad1bcc7994768a149691e60bb2c5d32064dd2c71f122f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.22.0/remora-etcher-x86_64-apple-darwin.tar.xz"
      sha256 "c7442b07c0905e4634656febad7289c07584e1cfa664e6df5f52d7dd0e2cb398"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.22.0/remora-etcher-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0655bf76145177226f0a4849a0194a2b5f5d96458f563716fc4a7f9e474a30e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.22.0/remora-etcher-x86_64-unknown-linux-musl.tar.xz"
      sha256 "eb252d279a3412cadb9051672526de906fe047c4d00854d0426947e6c47c5a4e"
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
