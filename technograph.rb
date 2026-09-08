# typed: strict
# frozen_string_literal: true

# Formula for the Technograph CLI and its local MCP server.
class Technograph < Formula
  desc "Evidence-first technographic detection CLI with hybrid browser scanning"
  homepage "https://github.com/b1rd33/technograph"
  url "https://github.com/b1rd33/technograph/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "3dfec62ad4a61b9b08da28698488a4831d7e3260f1f1b406c60cbb169cb36d5c"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/b1rd33/technograph/internal/buildinfo.Version=#{version}
      -X github.com/b1rd33/technograph/internal/buildinfo.Commit=729e47d
      -X github.com/b1rd33/technograph/internal/buildinfo.Date=2026-09-08T19:49:00Z
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"technograph", "./cmd/technograph"
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "),
           "-o", bin/"technograph-mcp", "./cmd/technograph-mcp"
  end

  test do
    assert_match "technograph #{version}", shell_output("#{bin}/technograph --version")
    assert_match "technograph #{version}", shell_output("#{bin}/technograph-mcp --version")
    assert_match "Usage: technograph scan", shell_output("#{bin}/technograph scan --help")
    assert_match "Usage: technograph explore", shell_output("#{bin}/technograph explore --help")
    assert_match "Technograph evidence report", shell_output("#{bin}/technograph explain https://invalid.example")
    assert_match "Usage: technograph-mcp", shell_output("#{bin}/technograph-mcp --help")
    assert_match "explain_domain", shell_output("#{bin}/technograph-mcp --help")
    assert_match '"status": "ok"', shell_output("#{bin}/technograph validate example.com")
  end
end
