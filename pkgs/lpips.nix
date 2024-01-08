{ lib
, python3Packages
, fetchPypi
}:

python3Packages.buildPythonPackage rec {
  pname = "lpips";
  version = "0.1.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-OEYzHfbGloiuw9MApe7vbFKUNbyEYL1YIBw9YuVhiPo=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    numpy
    scipy
    torch
    torchvision
    tqdm
  ];

  pythonImportsCheck = [ "lpips" ];

  meta = with lib; {
    description = "LPIPS Similarity metric";
    homepage = "https://pypi.org/project/lpips/";
    license = licenses.bsd2;
  };
}
