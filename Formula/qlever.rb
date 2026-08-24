class Qlever < Formula
  desc "High-performance graph database implementing the RDF and SPARQL standards"
  homepage "https://github.com/ad-freiburg/qlever"
  version "0.6.0"
  revision 1
  license "Apache-2.0"
  
  url "https://packages.qlever.dev/mac/qlever_0.6.0-1_macos_arm64.tar.gz"
  sha256 "e496c08902a8e4a2262dfcea8106f00feaa6060cabdfcf55e4838639396022f3"

  depends_on "icu4c@78"
  depends_on "jemalloc"
  depends_on "openssl@3"
  depends_on "qlever-control"
  depends_on "xz"
  depends_on "zstd"
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
