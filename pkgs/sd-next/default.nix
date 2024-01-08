{
  lib,
  fetchFromGitHub,
  python3Packages,
  pkgs,
  python3,
  basicsr,
  blendmodes,
  clip-interrogator,
  compel,
  diffusers,
  easydev,
  extcolors,
  facexlib,
  gfpgan,
  lpips,
  open-clip-torch,
  tensordict,
  tomesd,
  rembg,
}: let
  pytorch-lightning1-9-4 = python3Packages.buildPythonPackage rec {
    pname = "pytorch-lightning";
    version = "1.9.4";
    pyproject = true;

    src = python3Packages.fetchPypi {
      inherit pname version;
      hash = "sha256-GIp/RGis8jUS5/SQMlPYb8eSmknwwJ1pmHLjZBYgAeg=";
    };

    nativeBuildInputs = with python3Packages; [
      setuptools
      wheel
    ];

    propagatedBuildInputs = with python3Packages; [
      fsspec
      lightning-utilities
      numpy
      packaging
      pyyaml
      torch
      torchmetrics
      tqdm
      typing-extensions
    ];

    passthru.optional-dependencies = {
      all = with python3Packages; [
        bitsandbytes
        deepspeed
        gym
        hydra-core
        ipython
        jsonargparse
        lightning-utilities
        matplotlib
        omegaconf
        rich
        tensorboardx
        torchmetrics
        torchvision
      ];
      deepspeed = with python3Packages; [
        deepspeed
      ];
      dev = with python3Packages; [
        bitsandbytes
        cloudpickle
        coverage
        deepspeed
        fastapi
        gym
        hydra-core
        ipython
        jsonargparse
        lightning-utilities
        matplotlib
        omegaconf
        onnx
        onnxruntime
        pandas
        psutil
        pytest
        pytest-cov
        pytest-random-order
        pytest-rerunfailures
        pytest-timeout
        rich
        scikit-learn
        tensorboard
        tensorboardx
        torchmetrics
        torchvision
        uvicorn
      ];
      examples = with python3Packages; [
        gym
        ipython
        lightning-utilities
        torchmetrics
        torchvision
      ];
      extra = with python3Packages; [
        bitsandbytes
        hydra-core
        jsonargparse
        matplotlib
        omegaconf
        rich
        tensorboardx
      ];
      strategies = with python3Packages; [
        deepspeed
      ];
      test = with python3Packages; [
        cloudpickle
        coverage
        fastapi
        onnx
        onnxruntime
        pandas
        psutil
        pytest
        pytest-cov
        pytest-random-order
        pytest-rerunfailures
        pytest-timeout
        scikit-learn
        tensorboard
        uvicorn
      ];
    };

    pythonImportsCheck = ["pytorch_lightning"];

    meta = with lib; {
      description = "PyTorch Lightning is the lightweight PyTorch wrapper for ML researchers. Scale your models. Write less boilerplate";
      homepage = "https://pypi.org/project/pytorch-lightning/";
      license = licenses.asl20;
    };
  };

  themes = pkgs.fetchurl {
    url = "https://huggingface.co/datasets/freddyaboulton/gradio-theme-subdomains/resolve/main/subdomains.json";
    hash = "sha256-VZ684aJH45UuNenoen0JGFrAniVFmGdX53tKrpu12qE=";
  };
in
  python3Packages.buildPythonPackage rec {
    pname = "sd-next";
    version = "unstable-2023-11-24";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "vladmandic";
      repo = "automatic";
      rev = "a4a7a937a644c59a74a67ee1c53e2ceb0efc778c";
      hash = "sha256-m5LgSVqCKEZycwM31BagrpxVECdyLZtu0ZlTbuxLCqk=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = with python3Packages; [
      setuptools
      wheel
    ];

    propagatedBuildInputs = with python3Packages; [
      accelerate
      addict
      aenum
      aiohttp
      antlr4-python3-runtime
      anyio
      appdirs
      astunparse
      basicsr
      blendmodes
      clean-fid
      clip-interrogator
      compel
      dctorch
      diffusers
      easydev
      einops
      extcolors
      facexlib
      fasteners
      filetype
      future
      gdown
      gfpgan
      gitpython
      gradio
      httpcore
      httpx
      huggingface-hub
      inflection
      jsonmerge
      kornia
      lark
      lmdb
      lpips
      numba
      numexpr
      numpy
      omegaconf
      open-clip-torch
      pandas
      piexif
      pillow
      protobuf
      psutil
      pydantic
      pytorch-lightning1-9-4
      pyyaml
      requests
      resize-right
      rich
      safetensors
      scikit-image
      scipy
      setuptools
      tensorboard
      tensordict
      timm
      tomesd
      toml
      torchdiffeq
      torchsde
      tqdm
      transformers
      typing-extensions
      urllib3
      voluptuous
      yapf
      k-diffusion

      # extensions-builtin
      sqlalchemy
      rembg
      onnxruntime
      pooch
      invisible-watermark
    ];

    postInstall = ''
      cp *.py $out/lib

      cp -r modules $out/lib/python3*/site-packages/
      cp -r repositories $out/lib
      cp -r extensions-builtin  $out/lib
      cp -r CHANGELOG.md $out/lib
      cp -r scripts $out/lib
      cp -r html $out/lib
      ln -s ${themes} $out/lib/html/themes.json

      cp -r javascript $out/lib
      cp -r configs $out/lib
    '';

    patches = [./0001-pyproject.patch];

    buildInputs = with pkgs; [
      findutils
    ];

    postPatch = ''
      substituteInPlace modules/styles.py \
        --replace \'html\' \'$out/lib/html\'

      substituteInPlace modules/theme.py \
        --replace \'javascript\' \'$out/lib/javascript\' \
        --replace \'html\' \'$out/lib/html\'

      substituteInPlace modules/sd_models_config.py \
        --replace \'configs\' \'$out/lib/configs\'

      substituteInPlace modules/paths.py \
        --replace "script_path = os.path.dirname(modules_path)" "script_path = '$out/lib'" \
        --replace "'models'" "os.path.join(os.getcwd(), 'models')" \
        --replace "os.path.join(data_path, models_config)" "os.path.join(os.getcwd(), models_config)" \
        --replace \"extensions-builtin\" \"$out/lib/extensions-builtin\"

      substituteInPlace modules/shared.py \
        --replace "'models'" "os.path.join(os.getcwd(), 'models')" \
        --replace "\"outputs/text\"" "os.path.join(os.getcwd(), \"outputs\", \"text\")" \
        --replace "\"outputs/image\"" "os.path.join(os.getcwd(), \"outputs\", \"image\")" \
        --replace "\"outputs/extras\"" "os.path.join(os.getcwd(), \"outputs\", \"extras\")" \
        --replace "\"outputs/save\"" "os.path.join(os.getcwd(), \"outputs\", \"save\")" \
        --replace "\"outputs/init-images\"" "os.path.join(os.getcwd(), \"outputs\", \"init-images\")" \
        --replace "\"outputs/grids\"" "os.path.join(os.getcwd(), \"outputs\", \"grids\")"

      substituteInPlace modules/modelloader.py \
        --replace shared.script_path \"$out/lib/python${python3.pythonVersion}/site-packages\"

      substituteInPlace modules/ui.py \
        --replace \'CHANGELOG.md\' \'$out/lib/CHANGELOG.md\' \
        --replace "if fn.startswith(script_path):" "if False:"

      substituteInPlace installer.py \
        --replace "log_file = os.path.join(os.path.dirname(__file__), 'sdnext.log')" "log_file = os.path.join(os.getcwd(), 'sdnext.log')" \
        --replace "'skip_git': False" "'skip_git': True"

      substituteInPlace launch.py \
        --replace "installer.install_requirements()" "" \
        --replace "installer.check_version()" "" \
        --replace "installer.check_modified_files()" "" \
        --replace "installer.install_packages()" "" \
        --replace "installer.install_submodules()" "" \
        --replace "installer.check_torch()" "" \
        --replace "'webui.py'" "'$out/lib/webui.py'"

      substituteInPlace modules/ui_extra_networks.py \
        --replace \'html/card-no-preview.png\' \'$out/lib/html/card-no-preview.png\'

      substituteInPlace webui.py \
        --replace \'html/logo.ico\' \'$out/lib/html/logo.ico\' \
        --replace "allowed_paths=[" "allowed_paths=['$out/lib', "

      substituteInPlace javascript/setHints.js \
        --replace "/file=html/locale_en.json" "/file=$out/lib/html/locale_en.json"

      substituteInPlace javascript/ui.js \
        --replace "/file=html/" "/file=$out/lib/html/"

      substituteInPlace extensions-builtin/sd-webui-controlnet/annotator/annotator_path.py \
        --replace "os.path.dirname(os.path.abspath(__file__))" "os.getcwd(), \"annotator\""

      substituteInPlace extensions-builtin/sd-webui-controlnet/scripts/controlnet_ui/preset.py \
        --replace "preset_directory = os.path.join(scripts.basedir(), \"presets\")" "preset_directory = os.path.join(os.getcwd(), \"presets\")"

      substituteInPlace extensions-builtin/stable-diffusion-webui-images-browser/scripts/wib/wib_db.py \
        --replace "scripts.basedir()" "os.getcwd(), \"images-browser\""

      substituteInPlace extensions-builtin/sd-webui-agent-scheduler/agent_scheduler/db/base.py \
        --replace "db_file = os.path.join(scripts.basedir(), \"task_scheduler.sqlite3\")" "db_file = os.path.join(os.getcwd(), \"task_scheduler.sqlite3\")"

      substituteInPlace extensions-builtin/sd-extension-system-info/scripts/system-info.py \
        --replace "bench_file = os.path.join(os.path.dirname(__file__), 'benchmark-data-local.json')" "bench_file = os.path.join(os.getcwd(), 'benchmark-data-local.json')"
    '';

    postFixup = ''
      chmod +x $out/lib/launch.py
      sed -i -e '1i#!/usr/bin/python' $out/lib/launch.py
      patchShebangs $out/lib/launch.py

      mkdir $out/bin
      ln -s $out/lib/launch.py $out/bin/sd-next

      wrapProgram "$out/bin/sd-next" \
        --prefix PYTHONPATH : "$PYTHONPATH" \
    '';

    meta = with lib; {
      description = "SD.Next: Advanced Implementation of Stable Diffusion";
      homepage = "https://github.com/vladmandic/automatic";
      changelog = "https://github.com/vladmandic/automatic/blob/${src.rev}/CHANGELOG.md";
      license = licenses.agpl3Only;
    };
  }
