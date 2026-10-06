class Rmra < Formula
  desc "Remora operator CLI: log in to sntns-platform and reach your devices through the remora channel"
  homepage "https://github.com/sntns/remora-companion"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.10.0/rmra-aarch64-apple-darwin.tar.xz"
      sha256 "0f48163b8f9b076f727c670472b489842053491dc0cc8aed016b3d4f221454a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.10.0/rmra-x86_64-apple-darwin.tar.xz"
      sha256 "3d4d99c575b871652e9b40c4733de01e0ef8ca8d35fdf5fb42f8b4bdf23cf6f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.10.0/rmra-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f32db2e94f2a0a488118bec2257d8230a7f48bff45b9efe14865cdbae145270f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.10.0/rmra-x86_64-unknown-linux-musl.tar.xz"
      sha256 "75ce4b70a3e38314af3fa692c9db9a5191051f211e537e474a8a028108f08fb5"
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
