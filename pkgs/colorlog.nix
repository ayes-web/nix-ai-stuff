{ lib
, python3Packages
, fetchPypi
}:

python3Packages.buildPythonPackage rec {
  pname = "colorlog";
  version = "6.7.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-vZS9IcHhP6x70xU/S8On3A6wl0uLwv3xqYnkdPblguU=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    colorama
  ];

  passthru.optional-dependencies = {
    development = with python3Packages; [
      black
      flake8
      mypy
      pytest
      types-colorama
    ];
  };

  pythonImportsCheck = [ "colorlog" ];

  meta = with lib; {
    description = "Add colours to the output of Python's logging module";
    homepage = "https://pypi.org/project/colorlog/";
    license = licenses.mit;
  };
}
