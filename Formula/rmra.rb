class Rmra < Formula
  desc "Remora operator CLI: log in to sntns-platform and reach your devices through the remora channel"
  homepage "https://github.com/sntns/remora-companion"
  version "0.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.7.2/rmra-aarch64-apple-darwin.tar.xz"
      sha256 "a555c49c0e046c39246c98c3e52c6bf826e4866b1cd837fadc93d9e527a14756"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.7.2/rmra-x86_64-apple-darwin.tar.xz"
      sha256 "41d63017b3739a1bfc0fbf98aed3ba34dfbfa1974d3e83ae7ae05ded2a954a3d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.7.2/rmra-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e705e345e2fac1ede428f02eaba596b2b942d59d12aec996d4d292ba6f6a1910"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.7.2/rmra-x86_64-unknown-linux-musl.tar.xz"
      sha256 "db034522cbdd801910d604f3572eeef10c98a373bd4bc71276f1edd49cbe2b96"
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
