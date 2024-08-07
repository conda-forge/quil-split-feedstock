@echo off

call maturin build --release --manifest-path=%SRC_DIR%\quil-py\quil-py\Cargo.toml --out %SRC_DIR%\wheels
call maturin build --release --manifest-path=%SRC_DIR%\quil-cli\quil-cli\Cargo.toml --out %SRC_DIR%\wheels

pushd %SRC_DIR%\quil-py
    call cargo-bundle-licenses --format yaml --output %RECIPE_DIR%\THIRDPARTY.yml
    copy /Y LICENSE %RECIPE_DIR%\LICENSE
popd
