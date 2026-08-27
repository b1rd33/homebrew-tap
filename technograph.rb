# typed: false
# frozen_string_literal: true

class Technograph < Formula
  desc "Conservative HTTP-only technographic detection CLI"
  homepage "https://github.com/b1rd33/technograph"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/b1rd33/technograph/releases/download/v0.1.0/technograph_0.1.0_darwin_x86_64.tar.gz"
      sha256 "54a938b8b648d0a40da4cb53c9253727ec7c466d64d6edd6eddc7edf07104007"
    end
    if Hardware::CPU.arm?
      url "https://github.com/b1rd33/technograph/releases/download/v0.1.0/technograph_0.1.0_darwin_arm64.tar.gz"
      sha256 "48606ff4c71ace45aa917eb98cded5291c1e54863cc1949db631ee74ba6abe49"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/b1rd33/technograph/releases/download/v0.1.0/technograph_0.1.0_linux_x86_64.tar.gz"
      sha256 "707c656a123ca2c4dbfaa61afb4b789097af68a9a93ed78fdc35f7e652b78521"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/b1rd33/technograph/releases/download/v0.1.0/technograph_0.1.0_linux_arm64.tar.gz"
      sha256 "02775fec6ce277ed8e950aae1b6b6c2b34aed84aa5b1a224dac49e363873e6c6"
    end
  end

  def install
    bin.install "technograph"
  end

  test do
    assert_match "technograph #{version}", shell_output("#{bin}/technograph --version")
  end
end
