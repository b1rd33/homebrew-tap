# typed: strict
# frozen_string_literal: true

# Formula for the Technograph CLI and its local MCP server.
class Technograph < Formula
  desc "Conservative HTTP-only technographic detection CLI"
  homepage "https://github.com/b1rd33/technograph"
  url "https://github.com/b1rd33/technograph/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "f635193b4d060f16ad2013e1d338fd8bd8d7f626b3f9021b209aad2f6669438f"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/b1rd33/technograph/internal/buildinfo.Version=#{version}
      -X github.com/b1rd33/technograph/internal/buildinfo.Commit=5fde542
      -X github.com/b1rd33/technograph/internal/buildinfo.Date=2026-08-28T14:30:16Z
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"technograph", "./cmd/technograph"
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "),
           "-o", bin/"technograph-mcp", "./cmd/technograph-mcp"
  end

  test do
    assert_match "technograph #{version}", shell_output("#{bin}/technograph --version")
    assert_match "technograph #{version}", shell_output("#{bin}/technograph-mcp --version")
    assert_match "Usage: technograph scan", shell_output("#{bin}/technograph scan --help")
    assert_match "Technograph evidence report", shell_output("#{bin}/technograph explain https://invalid.example")
    assert_match "Usage: technograph-mcp", shell_output("#{bin}/technograph-mcp --help")
    assert_match '"status": "ok"', shell_output("#{bin}/technograph validate example.com")
  end
end
