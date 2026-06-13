# homebrew-qlever
Custom Homebrew tap for QLever (pronounced "Clever") graph database implementing the RDF and SPARQL standards.

# Setup and Installation
You can add the custom tap and install the `qlever-index` and `qlever-server` binaries, along with `qlever` CLI tool in a MacOS terminal session using:

```zsh
brew tap qlever-dev/qlever
# Recent versions of Homebrew require third-party taps to be explicitly trusted
# Skip if your Homebrew is older
brew trust qlever-dev/qlever
brew install qlever
```

Recent versions of Homebrew require third-party taps to be explicitly trusted before their formulae will install, which is why the `brew trust` step is needed. If your Homebrew is older and does not have `brew trust`, you can skip that line.
