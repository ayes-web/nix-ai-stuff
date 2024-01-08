{ lib
, python3Packages
, fetchPypi
}:

python3Packages.buildPythonPackage rec {
  pname = "convcolors";
  version = "2.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-QDaEjpiudSq6xKVKy4ebZxH43PL3aIFchTZjWaKHwb0=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  passthru.optional-dependencies = {
    dev = with python3Packages; [
      pytest
      tox
      yapf
    ];
  };

  pythonImportsCheck = [ "convcolors" ];

  meta = with lib; {
    description = "Convert colors between different color spaces";
    homepage = "https://pypi.org/project/convcolors/";
    license = licenses.mit;
  };
}
