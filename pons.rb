class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.6"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.6/pons-darwin-amd64"
      sha256 "2ecf1e7174e86e4be8cd5fc9f0d90d4af33d050667c393a7de45db934051923a"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.6/pons-darwin-arm64"
      sha256 "3a74b52cefe5606c533fb27e8a6b71fd3186ebcc728d047cf16cdc5bc77a3cfc"
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
