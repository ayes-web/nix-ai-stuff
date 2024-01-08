{
  lib,
  fetchFromGitHub,
  python3Packages,
  colorlog,
}:
python3Packages.buildPythonPackage rec {
  pname = "easydev";
  version = "0.12.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "cokelaer";
    repo = "easydev";
    rev = "v${version}";
    hash = "sha256-KCDc8t+3/dVsi0YmcK7LfBjx38RmlYAolqhvUixBBWo=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    colorlog
  ];

  pythonImportsCheck = ["easydev"];

  meta = with lib; {
    description = "Common utilities to ease the development of Python packages";
    homepage = "https://github.com/cokelaer/easydev";
    license = licenses.bsd3;
  };
}
