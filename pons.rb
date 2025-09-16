class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.13"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.13/pons-darwin-amd64"
      sha256 "2ab87013c25709759c9a8ab3734bc0054702694ea0e966b431530e5dcfe3c344"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.13/pons-darwin-arm64"
      sha256 "563f1432085dfef54fab80f3991c87b5de9ea78c73b3cd7db87a69e2f05a2ea8"
    end
  end

  def install
    bin.install Dir["pons-"][0] => "pons"
    # Create the mgr alias
    bin.install_symlink "pons" => "pn"
  end

  test do
    # Test basic version command
    system "#{bin}/pons", "--version"
    system "#{bin}/pn", "--version"
    
    # Test BuildInfo version commands
    assert_match version.to_s, shell_output("#{bin}/pons version --short")
    assert_match "Platform:", shell_output("#{bin}/pons version")
    
    # Test JSON output is valid
    json_output = shell_output("#{bin}/pons version --json")
    assert_match "version", json_output
    assert_match "platform", json_output
  end
end
