class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.17"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.17/pons-darwin-amd64"
      sha256 "2b4c857f5f49a230ab7627602e386dc7a98539eeb01cf807d6243fedda5d6ee2"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.17/pons-darwin-arm64"
      sha256 "ec6d43f07a2f4d039d9bd0d81c8f099695cff782b0dccaf74549b3ff1eb77c2b"
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
