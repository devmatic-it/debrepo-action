#!/bin/bash

echo "input Arguments $1 $2 $3"


DEBFILE_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${PACKAGE}"

echo "GITHUB_REF is ${GITHUB_REF}"
echo "PACKAGE is ${PACKAGE}"
echo "CODENAME is ${CODENAME}"
echo "DEBFILE_URL is ${DEBFILE_URL}"
OUTPUT=$(ls)
echo "ls: ${OUTPUT}"
#apt-get update -y
#apt-get install -y --no-install-recommends reprepro
#reprepro --basedir REPOSITORY.PATH includedeb ${CODENAME} ${PACKAGE}
