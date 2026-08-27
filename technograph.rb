# typed: strict
# frozen_string_literal: true

# Formula for the Technograph CLI and its local MCP server.
class Technograph < Formula
  desc "Conservative HTTP-only technographic detection CLI"
  homepage "https://github.com/b1rd33/technograph"
  url "https://github.com/b1rd33/technograph/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c5f7eab72396883c169cd3158cc25ca536b1b9b647b836a0e1c2dec464673600"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/b1rd33/technograph/internal/buildinfo.Version=#{version}
      -X github.com/b1rd33/technograph/internal/buildinfo.Commit=1cbca18
      -X github.com/b1rd33/technograph/internal/buildinfo.Date=2026-08-27T09:13:57Z
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"technograph", "./cmd/technograph"
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "),
           "-o", bin/"technograph-mcp", "./cmd/technograph-mcp"
  end

  test do
    assert_match "technograph #{version}", shell_output("#{bin}/technograph --version")
    assert_match "technograph #{version}", shell_output("#{bin}/technograph-mcp --version")
    assert_match '"status": "ok"', shell_output("#{bin}/technograph validate example.com")
  end
end
