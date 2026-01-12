class Qlever < Formula
  desc "High-performance SPARQL engine for RDF knowledge graphs"
  homepage "https://github.com/ad-freiburg/qlever"
  version "0.5.38"
  license "Apache-2.0"

  depends_on "boost"                                                                                                                                                                                                                        
  depends_on "icu4c@77"                                                                                                                                                                                                                     
  depends_on "jemalloc"                                                                                                                                                                                                                     
  depends_on "openssl@3" 
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/tanmay-9/qlever/releases/download/v0.5.38/qlever-0.5.38-macos-arm64.tar.gz"
  sha256 "0dfa1e79b8b1840d5db5920cf115df9ae56f96961b31419ee7da0c02dc2ec3ad"

  def install
    bin.install "qlever-loader"
    bin.install "qlever-server"
  end

  def caveats
    <<~EOS
      QLever binaries have been installed:
        - qlever-loader: for loading and indexing data
        - qlever-server: start a SPARQL endpoint and query data

      Use QLever via the qlever CLI (pip install qlever).
      For more information: https://github.com/ad-freiburg/qlever-control
    EOS
  end

  test do
    assert_match "QLever", shell_output("#{bin}/qlever-server --help 2>&1", 1)
    assert_match "QLever", shell_output("#{bin}/qlever-loader --help 2>&1", 1)
  end
end
