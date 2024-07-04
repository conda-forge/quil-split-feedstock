#!/bin/bash

set -ex
# Try to lock the versions in Cargo.toml
grep version "${SRC_DIR}"/quil-py/Cargo.toml
grep version "${SRC_DIR}"/quil-cli/Cargo.toml

if [[ $(uname) == Linux ]]; then
  sed -i -E 's/version\s*=\s*"0.11.0/version = "0.10.0/' "${SRC_DIR}"/quil-py/Cargo.toml
  sed -i -E 's/version\s*=\s*"0.26.0/version = "=0.26.0/' "${SRC_DIR}"/quil-cli/Cargo.toml
elif [[ $(uname) == Darwin ]]; then
  sed -i '' -E 's/version\s*=\s*"0.11.0/version = "0.10.0/' "${SRC_DIR}"/quil-py/Cargo.toml
  sed -i '' -E 's/version\s*=\s*"0.26.0/version = "=0.26.0/' "${SRC_DIR}"/quil-cli/Cargo.toml
else
  echo "Unsupported OS"
  exit 1
fi

# Build quil-py and quil-cli wheels
maturin build \
  --release \
  --manifest-path="${SRC_DIR}"/quil-py/Cargo.toml \
  --strip \
  -Zno-index-update \
  --out "${SRC_DIR}"/wheels
maturin build \
  --release \
  --manifest-path="${SRC_DIR}"/quil-cli/Cargo.toml \
  --strip \
  -Zno-index-update \
  --out "${SRC_DIR}"/wheels

# Update license file
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

