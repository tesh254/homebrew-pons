class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.16"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.16/pons-darwin-amd64"
      sha256 "7f848b4a21d13f114ef63b4f7dcf8ada9ef2b304e8c058a193ba5a4e866d82e7"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.16/pons-darwin-arm64"
      sha256 "9e3ad3eec55f6e07db3dcf45bf2b802bb0bab0d851e0c17b370de13e795a0ab1"
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
