{ lib
, python3Packages
, fetchFromGitHub
, pkgs
}:

python3Packages.buildPythonPackage rec {
  pname = "tensordict";
  version = "0.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "tensordict";
    rev = "v${version}";
    hash = "sha256-+Osoz1632F/dEkG/o8RUqCIDok2Qc9Qdak+CCr9m26g=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    torch
    wheel
    pkgs.which
  ];

  propagatedBuildInputs = with python3Packages; [
    pybind11
    packaging
  ];

  pythonImportsCheck = [ "tensordict" ];

  meta = with lib; {
    description = "TensorDict is a pytorch dedicated tensor container";
    homepage = "https://github.com/pytorch/tensordict";
    license = licenses.mit;
  };
}
