class AvSpex < Formula
  include Language::Python::Virtualenv

  desc "Python project for NMAAHC media conservation lab"
  homepage "https://github.com/JPC-AV/JPC_AV_videoQC"
  url "https://github.com/JPC-AV/JPC_AV_videoQC/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "03fb3eb9db64655a5f88db5ebbc1002b2ee857ff71853f1e79d52e4ff68d5b4b" 
  license "GPL-3.0-only"

  depends_on "python@3.10"
  depends_on "pyqt@6"

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/92/ec/089608b791d210aec4e7f97488e67ab0d33add3efccb83a056cbafe3a2a6/setuptools-75.8.0.tar.gz"
    sha256 "c5afc8f407c626b8313a86e10311dd3f661c6cd9c09d4bf8c15c0e11f9f2b0e6"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/8a/98/2d9906746cdc6a6ef809ae6338005b3f21bb568bea3165cfc6a243fdc25c/wheel-0.45.1.tar.gz"
    sha256 "661e1abd9198507b1409a20c02106d9670b2576e916d58f520316666abca6729"
  end

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40/appdirs-1.4.4.tar.gz"
    sha256 "7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41"
  end

  resource "colorlog" do
    url "https://files.pythonhosted.org/packages/78/6b/4e5481ddcdb9c255b2715f54c863629f1543e97bc8c309d1c5c131ad14f2/colorlog-6.7.0.tar.gz"
    sha256 "bd94bd21c1e13fac7bd3153f4bc3a7dc0eb0974b8bc2fdf1a989e474f6e582e5"
  end

  resource "art" do
    url "https://files.pythonhosted.org/packages/b6/15/6c4ac6bf544a01230bad5b45ce4f624051b9dc9567875da05cfdbfc2cafa/art-6.1.tar.gz"
    sha256 "6ab3031e3b7710039e73497b0e750cadfe04d4c1279ce3a123500dbafb9e1b64"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/ef/f6/c15ca8e5646e937c148e147244817672cf920b56ac0bf2cc1512ae674be8/lxml-5.3.1.tar.gz"
    sha256 "106b7b5d2977b339f1e97efe2778e2ab20e99994cbb0ec5e55771ed0795920c8"
  end

  resource "pandas" do
    url "https://files.pythonhosted.org/packages/88/d9/ecf715f34c73ccb1d8ceb82fc01cd1028a65a5f6dbc57bfa6ea155119058/pandas-2.2.2.tar.gz"
    sha256 "9e79019aba43cb4fda9e4d983f8e88ca0373adbb697ae9c6c43093218de28b54"
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
    virtualenv_install_with_resources
  end

  test do
    system bin/"av-spex", "--version"
  end
end