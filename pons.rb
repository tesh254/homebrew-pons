class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.7"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.7/pons-darwin-amd64"
      sha256 "1c679cbac5e51bf00b2f98c54b4d3b572b6cc44a57a683dc0276aaf445edb207"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.7/pons-darwin-arm64"
      sha256 "87301682f4f07d2034813ab263cba0058c2f4a1e88c7b92a02ce62a32308787d"
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
