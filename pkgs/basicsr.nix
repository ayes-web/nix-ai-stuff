{
  lib,
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "basicsr";
  version = "1.4.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "XPixelGroup";
    repo = "BasicSR";
    rev = "v${version}";
    hash = "sha256-UfwwwF0h0c5oPeGhj0w5Zw2edjPNoQWNG4pKHBwMU2I=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
    cython
  ];

  propagatedBuildInputs = with python3Packages; [
    addict
    future
    lmdb
    numpy
    opencv4
    pillow
    pyyaml
    requests
    scikit-image
    scipy
    tensorboard
    torch
    torchvision
    tqdm
    yapf
  ];

  pythonImportsCheck = ["basicsr"];

  meta = with lib; {
    description = "Open Source Image and Video Restoration Toolbox";
    homepage = "https://github.com/XPixelGroup/BasicSR";
    license = licenses.asl20;
  };
}
