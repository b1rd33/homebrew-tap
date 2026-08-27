# This file is generated from the verified technograph release archives.
cask "technograph" do
  version "0.1.0"

  on_macos do
    on_arm do
      sha256 "48606ff4c71ace45aa917eb98cded5291c1e54863cc1949db631ee74ba6abe49"
      url "https://github.com/b1rd33/technograph/releases/download/v#{version}/technograph_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "54a938b8b648d0a40da4cb53c9253727ec7c466d64d6edd6eddc7edf07104007"
      url "https://github.com/b1rd33/technograph/releases/download/v#{version}/technograph_#{version}_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "02775fec6ce277ed8e950aae1b6b6c2b34aed84aa5b1a224dac49e363873e6c6"
      url "https://github.com/b1rd33/technograph/releases/download/v#{version}/technograph_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "707c656a123ca2c4dbfaa61afb4b789097af68a9a93ed78fdc35f7e652b78521"
      url "https://github.com/b1rd33/technograph/releases/download/v#{version}/technograph_#{version}_linux_x86_64.tar.gz"
    end
  end

  name "technograph"
  desc "Conservative HTTP-only technographic detection CLI"
  homepage "https://github.com/b1rd33/technograph"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "technograph"

  # No zap stanza required.
end
