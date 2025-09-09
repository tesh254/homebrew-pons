class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.10"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.10/pons-darwin-amd64"
      sha256 "9547aacb4c1f07d45dfcf0fe0a11af18d886eb5fdc84793794b0dada8d133107"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.10/pons-darwin-arm64"
      sha256 "5d29a51d5ef55504c21a3c0654964acdc3f6eaf8fa9e710f1779522b9b824e06"
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
