class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.5/pons-darwin-amd64"
      sha256 "56cd1794a23d04f0c7933db57ee6ad83cfdafc6ddc644d66e627fa7f9a75d273"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.5/pons-darwin-arm64"
      sha256 "625a9c2c57f1870b3d4163879ed2d2238e1fd4f031b50e3402db7ac8b1b75cd8"
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
