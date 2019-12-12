#!/usr/bin/env bash

set -e

BRANCH=${BRANCH:-master}
DEPLOY_ENV=${DEPLOY_ENV:-prod}
DEPLOY_DIR="/opt/digital_collex"
APP="digital_collex"
DEPLOY_SERVER="lib-elixir-test1"
DEPLOY_USER="deploy"
KEYFILE="/home/deploy/.ssh/id_deploy"
SSH_PARAMS="-i ${KEYFILE} -o StrictHostKeyChecking=no"

if [[ $DEPLOY_ENV == "production" ]]; then
	DEPLOY_ENV="prod"
fi

function deploy() {
  rm -rf /tmp/digital_collex
  git clone --single-branch --depth 1 --branch $BRANCH https://github.com/pulibrary/digital_collections_elixir_example.git /tmp/digital_collex
  cd /tmp/digital_collex
  VERSION=`awk '/@version \"(.*)\"/{ print $2 }' ./mix.exs | cut -d '"' -f2`
  docker run -v $(pwd):/build -w /build -e MIX_ENV=$DEPLOY_ENV samvera/elixir-build bash -c "mix deps.get --only=prod && mix release --overwrite"
  scp ${SSH_PARAMS} _build/${DEPLOY_ENV}/${APP}-${VERSION}.tar.gz ${DEPLOY_USER}@${DEPLOY_SERVER}:${DEPLOY_DIR}
  ssh ${SSH_PARAMS} ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} && tar -xzf ${APP}-${VERSION}.tar.gz"
  ssh ${SSH_PARAMS} ${DEPLOY_USER}@${DEPLOY_SERVER} -- "cd ${DEPLOY_DIR} && ./bin/digital_collex eval 'DigitalCollex.ReleaseTasks.migrate()'"
  ssh ${SSH_PARAMS} ${DEPLOY_USER}@${DEPLOY_SERVER} -- "sudo service elixir-server restart"
}

deploy
