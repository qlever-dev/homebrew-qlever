class Qlever < Formula
  desc "High-performance graph database implementing the RDF and SPARQL standards"
  homepage "https://github.com/ad-freiburg/qlever"
  version "0.5.38"
  license "Apache-2.0"
  
  url "https://github.com/tanmay-9/qlever/releases/download/v0.5.38/qlever-0.5.38-macos-arm64.tar.gz"
  sha256 "4021173be61a69c37872652722b8959e9c52218f00821da26a9143c507e5db5f"

  depends_on "boost"                                                                                                                                                                                                                        
  depends_on "icu4c@77"                                                                                                                                                                                                                     
  depends_on "jemalloc"                                                                                                                                                                                                                     
  depends_on "openssl@3" 
  depends_on arch: :arm64
  depends_on :macos

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
    assert_match version.to_s, shell_output("#{bin}/qlever-loader --version")                                                                                                                                                                 
    assert_match version.to_s, shell_output("#{bin}/qlever-server --version")                                                                                                                                                                 
  end 
end
