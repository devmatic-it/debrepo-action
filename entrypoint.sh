#!/bin/bash

TAG=$(git tag)

https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_amd64.deb
DEBFILE_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}/${PACKAGE}"

echo "GITHUB_EVENT_PATH: ${GITHUB_EVENT_PATH}"
echo "GITHUB_REF: ${GITHUB_REF}"
echo "PACKAGE: ${PACKAGE}"
echo "CODENAME: ${CODENAME}"
echo "DEBFILE_URL: ${DEBFILE_URL}"
OUTPUT=$(ls)
echo "ls: ${OUTPUT}"
#apt-get update -y
#apt-get install -y --no-install-recommends reprepro
#reprepro --basedir REPOSITORY.PATH includedeb ${CODENAME} ${PACKAGE}
