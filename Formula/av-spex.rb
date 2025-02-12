class AvSpex < Formula
  include Language::Python::Virtualenv

  desc "Python project for NMAAHC media conservation lab"
  homepage "https://github.com/JPC-AV/JPC_AV_videoQC"
  url "https://github.com/JPC-AV/JPC_AV_videoQC/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "655558c1fe77d5a5a73b57425c308936a1f90588fc1327f901ea128c82f35327" 
  license "GPL-3.0-only"

  depends_on "python@3.12"
  depends_on "qt@6"

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40/appdirs-1.4.4.tar.gz"
    sha256 "7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41"
  end

  resource "ruamel.yaml" do
    url "https://files.pythonhosted.org/packages/29/81/4dfc17eb6692c337c3133ab86c28fcc07088c9320fc5125f2bcaf4a14d03/ruamel.yaml-0.18.6.tar.gz"
    sha256 "8b27e6a33c8516dcc97accd45a8d6853051767051a135fae51068f8f29a9e8b0"
  end

  resource "colorlog" do
    url "https://files.pythonhosted.org/packages/78/6b/4e5481ddcdb9c255b2715f54c863629f1543e97bc8c309d1c5c131ad14f2/colorlog-6.7.0.tar.gz"
    sha256 "bd94bd21c1e13fac7bd3153f4bc3a7dc0eb0974b8bc2fdf1a989e474f6e582e5"
  end

  resource "art" do
    url "https://files.pythonhosted.org/packages/43/ed/42f0f1cd221ec9d30afcf83f910f175963f5df5552e21e4a241bb087acd4/art-6.1.tar.gz"
    sha256 "c52092458c84829de6bd4ef973f87c0de3f0ff36adb853fb3ba7241f2ad36e7c"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/2b/b4/bbccb250adbee490553b6a52712c46c20ea1ba533a643f1424b27ffc6845/lxml-5.2.0.tar.gz"
    sha256 "a67999fe34cd3adfb5847164823a7ad4571456a0496098a59ed84770762f5550"
  end

  resource "pandas" do
    url "https://files.pythonhosted.org/packages/3d/85/04c9c049c7f889d3ab161cdb34f15ef23a5e6679f71d3f15d96f2ad2924d/pandas-2.2.2.tar.gz"
    sha256 "09d8be7dd9e1c4c98224c4dfd38de4920cbd6e144b9dd0d26867386f1ece10d0"
  end

  resource "plotly" do
    url "https://files.pythonhosted.org/packages/5b/44/7437cf71b86b5c8f749623bb578499de1bada4e71fd4dcca0eeae33183ac/plotly-5.23.0.tar.gz"
    sha256 "d35a57f6789f98db60fff3bd2ca02849378a5610c36fdede78875d602b639a70"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "PyQt6" do
    url "https://files.pythonhosted.org/packages/49/8b/7a63162fc9e32d8fd6e71af539c51e793c126ebef84103ef70ef5c0a1ac5/PyQt6-6.7.1.tar.gz"
    sha256 "5952de970e85e373acb852279590fb0bb12fa4eff0ca4937cefb5e67074c48cf"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"av-spex", "--version"
  end
end