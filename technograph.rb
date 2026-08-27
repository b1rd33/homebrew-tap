# typed: false
# frozen_string_literal: true

class Technograph < Formula
  desc "Conservative HTTP-only technographic detection CLI"
  homepage "https://github.com/b1rd33/technograph"
  url "https://github.com/b1rd33/technograph/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "64781b203c469004925687e74cff4ef8f9a82aa03de6cb07b9035ed65fbea99a"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/b1rd33/technograph/internal/buildinfo.Version=#{version}
      -X github.com/b1rd33/technograph/internal/buildinfo.Commit=395b011
      -X github.com/b1rd33/technograph/internal/buildinfo.Date=2026-08-27T08:08:38Z
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"technograph", "./cmd/technograph"
  end

  test do
    assert_match "technograph #{version}", shell_output("#{bin}/technograph --version")
  end
end
