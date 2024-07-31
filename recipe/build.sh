#!/bin/bash

set -ex

pushd "${SRC_DIR}"/quil-py/quil-py
  maturin build \
    --release \
    --strip \
    --out "${SRC_DIR}"/wheels

  cargo-bundle-licenses --format yaml --output "${RECIPE_DIR}"/THIRDPARTY.yml
popd

pushd "${SRC_DIR}"/quil-cli/quil-cli
  maturin build \
    --release \
    --strip \
    --out "${SRC_DIR}"/wheels
popd

