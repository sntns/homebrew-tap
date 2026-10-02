class Rmra < Formula
  desc "Remora operator CLI: log in to sntns-platform and reach your devices through the remora channel"
  homepage "https://github.com/sntns/remora-companion"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.5.0/rmra-aarch64-apple-darwin.tar.xz"
      sha256 "4b0012eca516571f3eac3694ddb414dee1cb5e78ad58586161e60f4673cbfdb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.5.0/rmra-x86_64-apple-darwin.tar.xz"
      sha256 "94200ef9ba4b739a1bd6e80d1f58c86f45c08d2360ccd9f9b9b24962305d5d7f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sntns/remora-companion/releases/download/v0.5.0/rmra-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1efb762f3f5d4caaf3281b7bce60419ace4ac6a1a3f474d8116d37772f551c05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sntns/remora-companion/releases/download/v0.5.0/rmra-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c7760fa5c5d50eeb961a3ac12ff821c67be43373f7ba1af45298327aa951de22"
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
