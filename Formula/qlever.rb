class Qlever < Formula
  desc "High-performance graph database implementing the RDF and SPARQL standards"
  homepage "https://github.com/ad-freiburg/qlever"
  version "0.5.48"
  license "Apache-2.0"
  
  url "https://packages.qlever.dev/mac/qlever_0.5.48_macos_arm64.tar.gz"
  sha256 "63917095213f75b31c4a5b071e5ac1f8211cec38324f00175ccca974bc3025eb"

  depends_on "boost"
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
