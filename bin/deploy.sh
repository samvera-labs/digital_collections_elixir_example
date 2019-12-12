#!/usr/bin/env sh

BRANCH=${BRANCH:-master}
DEPLOY_ENV=${DEPLOY_ENV:-prod}
DEPLOY_DIR="/opt/digital_collex"
APP="digital_collex"
DEPLOY_SERVER="lib-elixir-test1"
DEPLOY_USER="deploy"

function deploy() {
  rm -rf /tmp/digital_collex
  git clone --single-branch --depth 1 --branch $BRANCH https://github.com/samvera-labs/digital_collections_elixir_example.git /tmp/digital_collex
  cd /tmp/digital_collex
  VERSION=`awk '/@version \"(.*)\"/{ print $2 }' ./mix.exs | cut -d '"' -f2`
  docker run -v $(pwd):/build -w /build -e MIX_ENV=$DEPLOY_ENV -ti samvera/elixir-build bash -c "mix deps.get && mix release --overwrite"
  scp _build/${DEPLOY_ENV}/${APP}-${VERSION}.tar.gz ${DEPLOY_USER}@${DEPLOY_SERVER}:${DEPLOY_DIR}
  ssh ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} && tar -xzf ${APP}-${VERSION}.tar.gz"
  ssh ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} && ./bin/digital_collex eval 'DigitalCollex.ReleaseTasks.migrate()'"
  ssh ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} sudo service elixir-server restart"
}

deploy
