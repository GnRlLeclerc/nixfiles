#!/bin/env bash

# Ask for the path to the micromamba
echo "Please enter the path to the micromamba installation (default: /Data/micromamba):"
read -r micromamba_path
micromamba_path=${micromamba_path:-/Data/micromamba}

echo "Please enter the path to pytorch model cache (default: /Data/thibaut.de-saivre/.cache/):"
read -r pytorch_model_cache
pytorch_model_cache=${pytorch_model_cache:-/Data/thibaut.de-saivre/.cache/torch_extensions/}

pytorch_extensions_dir="torch_extensions/"

if which micromamba >/dev/null 2>&1; then
  echo "micromamba already configured in your PATH."
else
  # Installing micromamba
  "${SHELL}" <(curl -L micro.mamba.pm/install.sh) <<<"$HOME/.local/bin\nY\nY"

  # Add necessary environment variables to the shell profile
  env_variables=$(
    cat <<EOF
export MAMBA_ROOT_PREFIX="$micromamba_path"

# Cuda setup
export TORCH_EXTENSIONS_DIR=$pytorch_model_cache$pytorch_extensions_dir
export TORCH_HOME=$pytorch_model_cache
export CUDA_HOME=/usr/local/cuda/
export CUDA_TOOLKIT_ROOT_DIR=\$CUDA_HOME
export LD_LIBRARY_PATH="\$CUDA_HOME/extras/CUPTI/lib64:\$LD_LIBRARY_PATH"
export LIBRARY_PATH=\$CUDA_HOME/lib64:\$LIBRARY_PATH
export LD_LIBRARY_PATH=\$CUDA_HOME/lib64:\$LD_LIBRARY_PATH
export CFLAGS="-I\$CUDA_HOME/include \$CFLAGS"
EOF
  )

  # Append the environment variables to the shell profile (only if not already present)
  if ! grep -q "MAMBA_ROOT_PREFIX" ~/.bashrc; then
    echo "$env_variables" >>~/.bashrc
    echo "Environment variables added to ~/.bashrc."
  else
    echo "Environment variables already present in ~/.bashrc."
  fi
fi
