{
  lib,
  python3Packages,
  fetchPypi,
}:
python3Packages.buildPythonPackage rec {
  pname = "pymatting";
  version = "1.1.11";
  pyproject = true;

  src = fetchPypi {
    pname = "PyMatting";
    inherit version;
    hash = "sha256-A6VBm3m5HImNxlWz6upexrIJ0fUdTQfoGXBLXS10waU=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    numba
    numpy
    pillow
    scipy
  ];

  pythonImportsCheck = ["pymatting"];

  meta = with lib; {
    description = "Python package for alpha matting";
    homepage = "https://pypi.org/project/PyMatting/";
    license = licenses.mit;
  };
}
