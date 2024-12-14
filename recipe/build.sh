#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Patch package.json to skip unnecesary prepare step
mv package.json package.json.bak
jq 'del(.scripts.prepare)' package.json.bak > package.json

npm pack --ignore-scripts
npm install -ddd \
    --global \
    --build-from-source \
    ${SRC_DIR}/${PKG_NAME}-${PKG_VERSION}.tgz

tee ${PREFIX}/bin/typescript-language-server.cmd << EOF
call %CONDA_PREFIX%\bin\node %CONDA_PREFIX%\bin\typescript-language-server %*
EOF
