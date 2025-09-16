class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.14"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.14/pons-darwin-amd64"
      sha256 "5285ab98670c846d4c3570645878508243b28bdd4554ea815dac97ece23f6266"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.14/pons-darwin-arm64"
      sha256 "d557e7f6a5c858894f1ae8bd8d3c9ad9c1b2f9fbe28445ac0d042ebd72dec3da"
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
