#!/bin/sh
set -e

yarn install || exit $?
yarn restore || exit $? # am i persisting data?
yarn migrate || exit $?
yarn db new || exit $?

if [ "$VS_ENV" = 'dev' ]; then
  yarn dev
else
  yarn start
fi
