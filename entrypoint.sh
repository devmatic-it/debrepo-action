#!/bin/bash -l

set -ex

# get input parameters from args
CODENAME=$1
PACKAGE=$2

DEBFILE_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${GITHUB_REF}/${PACKAGE}"

echo "GITHUB_REF is ${GITHUB_REF}"
echo "PACKAGE is ${PACKAGE}"
echo "CODENAME is ${CODENAME}"
echo "DEBFILE_URL is ${DEBFILE_URL}"

#apt-get update -y
#apt-get install -y --no-install-recommends reprepro
#reprepro --basedir REPOSITORY.PATH includedeb ${CODENAME} ${PACKAGE}
