class RemoraEtcher < Formula
  desc "Standalone provisioning and flashing tool for Remora devices"
  homepage "https://github.com/sntns/remora-companion"
  version "0.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.17.0/remora-etcher-aarch64-apple-darwin.tar.xz"
      sha256 "7c6e4efbf8db5dd9df7e7b64b2d74a07c67f665d91cec865491676f976b542c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.17.0/remora-etcher-x86_64-apple-darwin.tar.xz"
      sha256 "b3f544aff4a16eb63ddf890e32a8eb84d724f3fd434bfdb766b0e67bc15fe953"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.17.0/remora-etcher-aarch64-unknown-linux-musl.tar.xz"
      sha256 "49942b3330f8138103e96d546b56c002482febeae8fc879807d61b25e870ca7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.17.0/remora-etcher-x86_64-unknown-linux-musl.tar.xz"
      sha256 "345189554c04a1473c07bdcb6d152adecbb2ba226b6891dd105ab9cd8fb6bb37"
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
