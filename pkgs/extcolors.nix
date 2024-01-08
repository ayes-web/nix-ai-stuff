{ lib
, fetchPypi
, python3Packages
, convcolors
}:

python3Packages.buildPythonPackage rec {
  pname = "extcolors";
  version = "1.0.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-FOgUV/mFVbo2wHpd3md9HVVej0t1YzpPrULfMKJ8Tyc=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    convcolors
    pillow
  ];

  passthru.optional-dependencies = {
    dev = with python3Packages; [
      pytest
      tox
      yapf
    ];
  };

  pythonImportsCheck = [ "extcolors" ];

  meta = with lib; {
    description = "Extract colors from an image. Colors are grouped based on visual similarities using the CIE76 formula";
    homepage = "https://pypi.org/project/extcolors/";
    license = licenses.mit;
  };
}
