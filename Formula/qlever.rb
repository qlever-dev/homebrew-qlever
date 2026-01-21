class Qlever < Formula
  desc "High-performance graph database implementing the RDF and SPARQL standards"
  homepage "https://github.com/ad-freiburg/qlever"
  version "0.5.44"
  license "Apache-2.0"
  
  url "https://packages.qlever.dev/mac/qlever_0.5.44_macos_arm64.tar.gz"
  sha256 "c8d87fe8b5d1ef47c8e7dd8daa2f882fba28190ca7fb1d405f9540bea1460cb4"

  depends_on "boost@1.90"
  depends_on "icu4c@78"
  depends_on "jemalloc"
  depends_on "openssl@3"
  depends_on "qlever-control"
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "qlever-index"
    bin.install "qlever-server"
  end

  def caveats
    <<~EOS
      QLever binaries have been installed:
        - qlever-index: for loading and indexing data
        - qlever-server: start a SPARQL endpoint and query data
        - qlever: CLI tool for controlling (almost) everything QLever can do

      For more information: https://github.com/ad-freiburg/qlever-control
    EOS
  end

  test do                                                                                                                                                                                                                                     
    assert_match version.to_s, shell_output("#{bin}/qlever-index --version")                                                                                                                                                                 
    assert_match version.to_s, shell_output("#{bin}/qlever-server --version")                                                                                                                                                                 
  end 
end
