{ lib
, python3Packages
, fetchFromGitHub
, diffusers
}:

python3Packages.buildPythonPackage rec {
  pname = "compel";
  version = "2.0.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "damian0815";
    repo = "compel";
    rev = "v${version}";
    hash = "sha256-OHldDlHtxSs112rmy/DsZPV6TIhsmfAzcxH2rjJ9cR4=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    diffusers
    pyparsing
    torch
    transformers
  ];

  pythonImportsCheck = [ "compel" ];

  meta = with lib; {
    description = "A prompting enhancement library for transformers-type text embedding systems";
    homepage = "https://github.com/damian0815/compel";
    license = licenses.mit;
  };
}
