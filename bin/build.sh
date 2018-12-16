#!/bin/bash -xe

cd "$(dirname "$0")/.."

source bin/env

rm -rf build/

# builds a debian to build/distributions/*.deb
# runs as root in the container for some build systems
docker run -u root --rm \
  -e PACKAGE_NAME="${APP_NAME}" \
  -e BUILD_NUMBER="${BUILD_NUMBER}" \
  -e BRANCH_NAME="${BRANCH_NAME}" \
  -v $(pwd)/.gradle-cache:/root/.gradle/ \
  -v $(pwd)/:/home/gradle/ \
  gradle:4.10-jre11-slim \
  gradle --no-daemon buildDeb


# builds an rpm to build/distributions/*.rpm
# runs as root in the container for some build systems
docker run -u root --rm \
  -e PACKAGE_NAME="${APP_NAME}" \
  -e BUILD_NUMBER="${BUILD_NUMBER}" \
  -e BRANCH_NAME="${BRANCH_NAME}" \
  -v $(pwd)/.gradle-cache:/root/.gradle/ \
  -v $(pwd)/:/home/gradle/ \
  gradle:4.10-jre11-slim \
  gradle --no-daemon buildRpm
