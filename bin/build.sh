#!/bin/bash -xe

cd "$(dirname "$0")/.."

source bin/env

rm -rf build/

# builds a debian to build/distributions/*.deb
docker run --rm \
  -e BUILD_NUMBER="${BUILD_NUMBER}" \
  -e BRANCH_NAME="${BRANCH_NAME}" \
  -v $(pwd)/.gradle-cache:/home/gradle/.gradle/ \
  -v $(pwd)/:/home/gradle/ \
  gradle:4.10-jre11-slim \
  gradle --no-daemon buildDeb


# builds an rpm to build/distributions/*.rpm
docker run --rm \
  -e BUILD_NUMBER="${BUILD_NUMBER}" \
  -e BRANCH_NAME="${BRANCH_NAME}" \
  -v $(pwd)/.gradle-cache:/home/gradle/.gradle/ \
  -v $(pwd)/:/home/gradle/ \
  gradle:4.10-jre11-slim \
  gradle --no-daemon buildRpm
