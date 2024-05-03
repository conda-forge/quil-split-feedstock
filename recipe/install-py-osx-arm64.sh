#!/usr/bin/env bash

set -ex

echo "Test python --version"
${PYTHON} --version

echo "Test pip module"
${PYTHON} -m pip --version

echo "Install quil python package"
${PYTHON} -m pip install quil \
  --no-build-isolation \
  --no-deps \
  --only-binary :all: \
  --no-index \
  --find-links=${SRC_DIR}/wheels/ \
  --prefix ${PREFIX} \
  -vv
