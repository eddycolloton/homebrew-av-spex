class AvSpex < Formula
  include Language::Python::Virtualenv

  desc "Python project for NMAAHC media conservation lab"
  homepage "https://github.com/JPC-AV/JPC_AV_videoQC"
  url "https://github.com/JPC-AV/JPC_AV_videoQC/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "03fb3eb9db64655a5f88db5ebbc1002b2ee857ff71853f1e79d52e4ff68d5b4b"
  license "GPL-3.0-only"

  depends_on "python@3.10"
  depends_on "qt@6"

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/92/ec/089608b791d210aec4e7f97488e67ab0d33add3efccb83a056cbafe3a2a6/setuptools-75.8.0.tar.gz"
    sha256 "c5afc8f407c626b8313a86e10311dd3f661c6cd9c09d4bf8c15c0e11f9f2b0e6"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "PyQt6" do
    url "https://files.pythonhosted.org/packages/d1/f9/b0c2ba758b14a7219e076138ea1e738c068bf388e64eee68f3df4fc96f5a/PyQt6-6.7.1.tar.gz"
    sha256 "3672a82ccd3a62e99ab200a13903421e2928e399fda25ced98d140313ad59cb9"
  end

  def install
    # Create virtualenv
    venv = virtualenv_create(libexec, "python3.10")

    venv.pip_install "setuptools"
    
    venv.pip_install "toml"

    # Create a temporary pyproject.toml to configure PyQt6 build
    pyproject = Pathname.new("pyproject.toml")
    pyproject.write <<~EOS
      [tool.sip.project]
      sip-include-dirs = []
      
      [tool.sip.bindings.PyQt6]
      license-type = "GPL"
      license-accepted = true
    EOS

    # Install PyQt6 with the temporary config
    system libexec/"bin/python", "-m", "pip", "install", "PyQt6"

    # Install the project itself
    venv.pip_install_and_link buildpath
  end

  test do
    system bin/"av-spex", "--version"
  end
end