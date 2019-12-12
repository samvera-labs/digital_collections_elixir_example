#!/usr/bin/env sh

BRANCH=${BRANCH:-master}
DEPLOY_ENV=${DEPLOY_ENV:-prod}

rm -rf /tmp/digital_collex
git clone --single-branch --branch $BRANCH https://github.com/samvera-labs/digital_collections_elixir_example.git /tmp/digital_collex
(cd /tmp/digital_collex && mix deps.get && docker run -v $(pwd):/build -w /build -e MIX_ENV=$DEPLOY_ENV -ti samvera/elixir-build bash -c "mix deps.get && mix release --overwrite")
