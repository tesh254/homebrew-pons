class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.4/pons-darwin-amd64"
      sha256 "8b124f3fb134289bd5453170c4ab1e3afe2e40e2861c26d920b116a445120fb7"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.4/pons-darwin-arm64"
      sha256 "f46aab0bb66a18081bf696924e5d3f29caadda4212ed974eebdcb620e83df68f"
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
    
    # Test BuildInfo version commands
    assert_match version.to_s, shell_output("#{bin}/pons version --short")
    assert_match "Platform:", shell_output("#{bin}/pons version")
    
    # Test JSON output is valid
    json_output = shell_output("#{bin}/pons version --json")
    assert_match "version", json_output
    assert_match "platform", json_output
  end
end
