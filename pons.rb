class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.6"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v0.0.1/pons-darwin-amd64"
      sha256 "b2a862e4d232bb48c68714aa40a39b50ab9e15fc53f6390b4c6b02f1159b8e72"
    else
      url "https://github.com/tesh254/pons/releases/download/v0.0.1/pons-darwin-arm64"
      sha256 "eeaf1f0911cef029ffdbac221e321f24fc48e66025ba747a4e541f9f1bf49129"
    end
  end

  def install
    bin.install Dir["pons-*"][0] => "pons"
    # Create the mgr alias
    bin.install_symlink "pons" => "pn"
  end

  test do
    # Test basic version command
    system "#{bin}/pons", "--version"
    system "#{bin}/pn", "--version"
  end
end
