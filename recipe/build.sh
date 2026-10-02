#!/bin/bash

set -ex

pushd "${SRC_DIR}"/quil-rs
  maturin build \
    --release \
    --strip \
    --compatibility off \
    --out "${SRC_DIR}"/wheels
popd

pushd "${SRC_DIR}"/quil-cli
  maturin build \
    --release \
    --strip \
    --compatibility off \
    --out "${SRC_DIR}"/wheels
popd

pushd "${SRC_DIR}"
  cargo-bundle-licenses --format yaml --output "${RECIPE_DIR}"/THIRDPARTY.yml
  cp LICENSE "${RECIPE_DIR}"/LICENSE
popd
