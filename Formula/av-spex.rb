
class AvSpex < Formula
  include Language::Python::Virtualenv

  desc "Python project for NMAAHC media conservation lab"
  homepage "https://github.com/JPC-AV/JPC_AV_videoQC"
  url "https://github.com/JPC-AV/JPC_AV_videoQC/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "5436a72a982fc1a4d90c0b7ddda7adf51438eed1f3817a00ebdb26e937d8e69f"
  license "GPL-3.0-only"

  bottle do
    rebuild 1
    root_url "https://github.com/JPC-AV/JPC_AV_videoQC/releases/download/v0.7.0"
    sha256 cellar: :any, 
    arm64_sonoma: "569067c4d0047c13b9b87de699ecd3d411d7c191ff9374b890f23eae914967ea"
  end

  depends_on "numpy" => :build # needed for lxml
  
  resource "setuptools" do # needed for pyqt6 
    url "https://files.pythonhosted.org/packages/92/ec/089608b791d210aec4e7f97488e67ab0d33add3efccb83a056cbafe3a2a6/setuptools-75.8.0.tar.gz"
    sha256 "c5afc8f407c626b8313a86e10311dd3f661c6cd9c09d4bf8c15c0e11f9f2b0e6"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "art" do
    url "https://files.pythonhosted.org/packages/b6/15/6c4ac6bf544a01230bad5b45ce4f624051b9dc9567875da05cfdbfc2cafa/art-6.1.tar.gz"
    sha256 "6ab3031e3b7710039e73497b0e750cadfe04d4c1279ce3a123500dbafb9e1b64"
  end

  resource "colorlog" do
    url "https://files.pythonhosted.org/packages/78/6b/4e5481ddcdb9c255b2715f54c863629f1543e97bc8c309d1c5c131ad14f2/colorlog-6.7.0.tar.gz"
    sha256 "bd94bd21c1e13fac7bd3153f4bc3a7dc0eb0974b8bc2fdf1a989e474f6e582e5"
  end

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40/appdirs-1.4.4.tar.gz"
    sha256 "7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/ef/f6/c15ca8e5646e937c148e147244817672cf920b56ac0bf2cc1512ae674be8/lxml-5.3.1.tar.gz"
    sha256 "106b7b5d2977b339f1e97efe2778e2ab20e99994cbb0ec5e55771ed0795920c8"
  end

  resource "plotly" do
    url "https://files.pythonhosted.org/packages/db/9e/31b2f0b8f2357cd5f3e992c76c3e4e85a5cbbad8b8c5f23d0684e3f4c608/plotly-5.23.0.tar.gz"
    sha256 "89e57d003a116303a34de6700862391367dd564222ab71f8531df70279fc0193"
  end

  resource "PyQt6" do
    url "https://files.pythonhosted.org/packages/d1/f9/b0c2ba758b14a7219e076138ea1e738c068bf388e64eee68f3df4fc96f5a/PyQt6-6.7.1.tar.gz"
    sha256 "3672a82ccd3a62e99ab200a13903421e2928e399fda25ced98d140313ad59cb9"
  end

  resource "PyQt6-sip" do
    url "https://files.pythonhosted.org/packages/90/18/0405c54acba0c8e276dd6f0601890e6e735198218d031a6646104870fe22/pyqt6_sip-13.10.0.tar.gz"
    sha256 "d6daa95a0bd315d9ec523b549e0ce97455f61ded65d5eafecd83ed2aa4ae5350"
  end


  def install
    # First ensure Python 3.10 is installed as keg-only
    system "brew", "install", "python@3.10"
    
    # Get the path to Python 3.10
    python_path = Utils.safe_popen_read("brew", "--prefix", "python@3.10").chomp
    python_bin = "#{python_path}/bin/python3.10"
    
    # Create a self-contained virtualenv
    system "python3", "-m", "venv", libexec
    
    # Use the virtualenv pip to install dependencies
    system "#{libexec}/bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    
    # Install plotly directly
    system "#{libexec}/bin/pip", "install", "--no-deps", "plotly==5.23.0"
    
    # Install Python resources
    resources.each do |r|
      next if r.name == "PyQt6" || r.name == "plotly"
      r.stage do
        system "#{libexec}/bin/pip", "install", "--no-deps", "."
      end
    end
    
    # Install PyQt6 with special flags
    system "#{libexec}/bin/pip", "install", "PyQt6", "--config-settings", "--confirm-license=", "--verbose"
    
    # Install the main package
    system "#{libexec}/bin/pip", "install", "--no-deps", "."
    
    # Create wrapper scripts that don't rely on shebang
    (bin/"av-spex").write <<~EOS
      #!/bin/sh
      # Find Python 3.10 at runtime
      PYTHON=$(command -v python3.10 || command -v python3)
      export PYTHONPATH="#{libexec}/lib/python3.10/site-packages:$PYTHONPATH"
      exec "$PYTHON" "#{libexec}/bin/av-spex" "$@"
    EOS
    
    (bin/"av-spex-gui").write <<~EOS
      #!/bin/sh
      # Find Python 3.10 at runtime
      PYTHON=$(command -v python3.10 || command -v python3)
      export PYTHONPATH="#{libexec}/lib/python3.10/site-packages:$PYTHONPATH"
      exec "$PYTHON" "#{libexec}/bin/av-spex-gui" "$@"
    EOS
    
    chmod 0755, bin/"av-spex"
    chmod 0755, bin/"av-spex-gui"
  end

  def caveats
    <<~EOS
      This formula requires Python 3.10 to be installed.
      If you experience issues, please ensure Python 3.10 is installed:
        brew install python@3.10
    EOS
  end

  test do
    system bin/"av-spex", "--version"
  end
end