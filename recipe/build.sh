#!/bin/bash

set -ex

# This attempts to verify that the version numbers for quil-py and quil-cli match with the ones we build
# All the upstream sources are the same for a given quil-rs version, however, it occurred that only the
# quil-rs version was updated, causing the actual quil-py distributed to be a different version than
# advertised. This test is meant to fail on such discrepancies.
diff -r verify-quil-py/quil-py "${SRC_DIR}"/quil-py
diff -r verify-quil-cli/quil-cli "${SRC_DIR}"/quil-cli

cd "${SRC_DIR}"/quil-rs
  cargo build
cd ..

cd "${SRC_DIR}"/quil-py
  cargo build
  maturin build \
    --release \
    --strip \
    --offline \
    --out "${SRC_DIR}"/wheels
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
