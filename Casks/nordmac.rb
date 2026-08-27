# This file is maintained from verified nordmac release assets.
cask "nordmac" do
  version "0.1.0"

  on_macos do
    on_arm do
      sha256 "1cba5c10ae8929ca1973542e81a0a58bfb287a5e6634a507435a762813f29584"
      url "https://github.com/b1rd33/nordmac/releases/download/v#{version}/nordmac_#{version}_darwin_arm64.tar.gz",
          verified: "github.com/b1rd33/nordmac"
    end
    on_intel do
      sha256 "2ff0b37ecd14cbec0154691ffbce599a7eda2e3e6666aa38c64eb96646a26e49"
      url "https://github.com/b1rd33/nordmac/releases/download/v#{version}/nordmac_#{version}_darwin_x86_64.tar.gz",
          verified: "github.com/b1rd33/nordmac"
    end
  end

  name "nordmac"
  desc "Read-only NordVPN location and NordLynx server recommendation CLI"
  homepage "https://github.com/b1rd33/nordmac"

  binary "nordmac"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/nordmac"]
  end

  # No zap stanza required; nordmac stores only a non-secret country cache.
end
