#!/usr/bin/env bash

set -e

BRANCH=${BRANCH:-master}
DEPLOY_ENV=${DEPLOY_ENV:-prod}
DEPLOY_DIR="/opt/digital_collex"
APP="digital_collex"
DEPLOY_SERVER="lib-elixir-test1"
DEPLOY_USER="deploy"

if [[ $DEPLOY_ENV == "production" ]]; then
	DEPLOY_ENV="prod"
fi

function deploy() {
  rm -rf /tmp/digital_collex
  git clone --single-branch --depth 1 --branch $BRANCH https://github.com/samvera-labs/digital_collections_elixir_example.git /tmp/digital_collex
  cd /tmp/digital_collex
  VERSION=`awk '/@version \"(.*)\"/{ print $2 }' ./mix.exs | cut -d '"' -f2`
  docker run -v $(pwd):/build -w /build -e MIX_ENV=$DEPLOY_ENV -ti samvera/elixir-build bash -c "mix deps.get && mix release --overwrite"
  scp -o StrictHostKeyChecking=no _build/${DEPLOY_ENV}/${APP}-${VERSION}.tar.gz ${DEPLOY_USER}@${DEPLOY_SERVER}:${DEPLOY_DIR}
  ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} && tar -xzf ${APP}-${VERSION}.tar.gz"
  ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} && ./bin/digital_collex eval 'DigitalCollex.ReleaseTasks.migrate()'"
  ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} sudo service elixir-server restart"
}

deploy
