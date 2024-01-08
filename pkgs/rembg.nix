{
  lib,
  python3Packages,
  fetchFromGitHub,
  pymatting,
}:
python3Packages.buildPythonPackage rec {
  pname = "rembg";
  version = "2.0.52";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "danielgatis";
    repo = "rembg";
    rev = "v${version}";
    hash = "sha256-6ukB+zJQRfpIHxHtdlgKw5zkHtPsU2mHxTl/NwBxi2Y=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    numpy
    opencv4
    pillow
    pymatting
  ];

  # pythonImportsCheck = ["rembg"];

  meta = with lib; {
    description = "Rembg is a tool to remove images background";
    homepage = "https://github.com/danielgatis/rembg";
    license = licenses.mit;
  };
}
