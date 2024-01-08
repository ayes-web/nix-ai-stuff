{ lib
, fetchFromGitHub
, python3Packages
, open-clip-torch
}:

python3Packages.buildPythonPackage rec {
  pname = "clip-interrogator";
  version = "0.6.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pharmapsychotic";
    repo = "clip-interrogator";
    rev = "v${version}";
    hash = "sha256-cccVl689afyBf5EDrlGQAfjUJbxE3CoOqoWrHtPRhPM=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    accelerate
    open-clip-torch
    pillow
    requests
    safetensors
    torch
    torchvision
    tqdm
    transformers
  ];

  pythonImportsCheck = [ "clip_interrogator" ];

  meta = with lib; {
    description = "Image to prompt with BLIP and CLIP";
    homepage = "https://github.com/pharmapsychotic/clip-interrogator";
    license = licenses.mit;
  };
}
