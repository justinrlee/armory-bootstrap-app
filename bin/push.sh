#!/bin/bash -xe

cd "$(dirname "$0")/.."

source bin/env

# Example using Bintray
##########################
BINTRAY_REPO="armory/armory-training" # your repo here
# BINTRAY_USER=
# BINTRAY_APIKEY=


BINTRAY_URL="https://api.bintray.com/content/${BINTRAY_REPO}"
DEB_FILE=$(ls build/distributions/*.deb)
VERSION=$(echo "${DEB_FILE}" | cut -d _ -f 2)
METADATA="deb_distribution=trusty;deb_component=main;publish=1;deb_architecture=i386,amd64"

curl -f -T ${DEB_FILE} \
  -u${BINTRAY_USER}:${BINTRAY_APIKEY} \
   "${BINTRAY_URL}/${APP_NAME}/${VERSION}/${DEB_FILE};${METADATA}"




# Example using s3 bucket
##########################
S3_PREFIX=${APP_NAME:-""}
AWS_ACCESS_KEY=${AWS_ACCESS_KEY:-""}
AWS_SECRET_KEY=${AWS_SECRET_KEY:-""}
S3_BUCKET=${S3_BUCKET:-"armory-training-deb-repo"}
S3_REGION=${S3_REGION:-"us-west-2"}

# use deb-s3 as our uploader
docker build -f Dockerfile.deb-s3 -t deb-s3 .

docker run --rm --name=deb-s3 \
  -v "$(pwd)/build/:/home/deb-s3/build/" \
  deb-s3 upload \
  --access-key-id=${AWS_ACCESS_KEY} \
  --secret-access-key=${AWS_SECRET_KEY} \
  --visibility=private \
  --encryption \
  --lock --fail-if-exists \
  --prefix=${S3_PREFIX} \
  --bucket ${S3_BUCKET} \
  --s3-region=${S3_REGION} \
  --arch amd64,i386 \
  $(ls build/distributions/*.deb)

# This will store your package in the repository:
# https://s3-us-west-2.amazonaws.com/armory-training-deb/armory-bootstrap-app stable main
