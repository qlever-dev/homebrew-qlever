class Qlever < Formula
  desc "High-performance graph database implementing the RDF and SPARQL standards"
  homepage "https://github.com/ad-freiburg/qlever"
  version "0.5.38"
  license "Apache-2.0"
  
  url "https://github.com/tanmay-9/qlever/releases/download/v0.5.42/qlever-0.5.42-macos-arm64.tar.gz"
  sha256 "b6710e494bb3784854fd3d05a48b122c51f6916dc73cd0a30e4d7f8b0fa7e9bb"

  depends_on "boost"
  depends_on "icu4c"
  depends_on "jemalloc"
  depends_on "openssl@3"
  depends_on "qlever-control"
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/qlever-index"
    bin.install "bin/qlever-server"
  end

  def caveats
    <<~EOS
      QLever binaries have been installed:
        - qlever-index: for loading and indexing data
        - qlever-server: start a SPARQL endpoint and query data
        - qlever: CLI tool for managing QLever instances

      For more information: https://github.com/ad-freiburg/qlever-control
    EOS
  end

  test do                                                                                                                                                                                                                                     
    assert_match version.to_s, shell_output("#{bin}/qlever-index --version")                                                                                                                                                                 
    assert_match version.to_s, shell_output("#{bin}/qlever-server --version")                                                                                                                                                                 
  end 
end
