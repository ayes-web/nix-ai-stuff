{
  lib,
  fetchPypi,
  python3Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "facexlib";
  version = "0.3.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-eueEpSDrUuBVg+i/n2j3f0UIMjmsdU1kbWNQF7Sed2M=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
    cython
  ];

  propagatedBuildInputs = with python3Packages; [
    filterpy
    numba
    numpy
    opencv4
    pillow
    scipy
    torch
    torchvision
    tqdm
  ];

  pythonImportsCheck = ["facexlib"];

  meta = with lib; {
    description = "Basic face library";
    homepage = "https://pypi.org/project/facexlib/";
    license = licenses.mit;
  };
}
