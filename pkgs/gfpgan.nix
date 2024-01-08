{
  lib,
  fetchFromGitHub,
  basicsr,
  facexlib,
  python3Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "gfpgan";
  version = "1.3.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "TencentARC";
    repo = "GFPGAN";
    rev = "v${version}";
    hash = "sha256-frJ3hSniHvCSEPB1awJsXLuUxYRRMbV9GS4GSPKwXOg=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
    cython
  ];

  propagatedBuildInputs = with python3Packages; [
    basicsr
    facexlib
    lmdb
    numpy
    opencv4
    pyyaml
    scipy
    tensorboard
    torch
    torchvision
    tqdm
    yapf
  ];

  pythonImportsCheck = ["gfpgan"];

  meta = with lib; {
    description = "GFPGAN aims at developing Practical Algorithms for Real-world Face Restoration";
    homepage = "https://github.com/TencentARC/GFPGAN";
    license = licenses.asl20;
  };
}
