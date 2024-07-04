#!/bin/bash

set -ex

cd "${SRC_DIR}"/quil-rs
  cargo build
cd ..

cd "${SRC_DIR}"/quil-py
  python -m build --no-isolation --wheel --outdir "${SRC_DIR}"/wheels
cd ..

cd "${SRC_DIR}"/quil-cli
  cargo build
  maturin build \
    --release \
    --strip \
    --offline \
    --out "${SRC_DIR}"/wheels
cd ..

# Update license file
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
