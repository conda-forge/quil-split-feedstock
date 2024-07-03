#!/bin/bash

set -ex
# Try to lock the versions in Cargo.toml
if [[ $(uname) == Linux ]]; then
  sed -i -E 's/version\s*=\s*"/version = "=/' "${SRC_DIR}"/quil-py/Cargo.toml
  sed -i -E 's/version\s*=\s*"/version = "=/' "${SRC_DIR}"/quil-cli/Cargo.toml
elif [[ $(uname) == Darwin ]]; then
  sed -i '' -E 's/version\s*=\s*"/version = "=/' "${SRC_DIR}"/quil-py/Cargo.toml
  sed -i '' -E 's/version\s*=\s*"/version = "=/' "${SRC_DIR}"/quil-cli/Cargo.toml
else
  echo "Unsupported OS"
  exit 1
fi

# Build quil-py and quil-cli wheels
maturin build \
  --release \
  --manifest-path="${SRC_DIR}"/quil-py/Cargo.toml \
  --strip \
  --out "${SRC_DIR}"/wheels
maturin build \
  --release \
  --manifest-path="${SRC_DIR}"/quil-cli/Cargo.toml \
  --strip \
  --out "${SRC_DIR}"/wheels

# Update license file
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

