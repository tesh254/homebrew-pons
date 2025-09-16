class Pons < Formula
  desc "A robust CLI tool used to organize and automate complex workflows with templated commands"
  homepage "https://github.com/tesh254/pons"
  version "1.0.19"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/tesh254/pons/releases/download/v1.0.19/pons-darwin-amd64"
      sha256 "d9e5d0a2169b8b9025fa8feed5d321500a74b2031d957c07e7bca88c7704488a"
    else
      url "https://github.com/tesh254/pons/releases/download/v1.0.19/pons-darwin-arm64"
      sha256 "008c83304fd10f7e679151cf5fd6fd3fdd310e1d681438b9d1c2ddf8bc8a30b4"
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
