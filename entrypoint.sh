#!/bin/bash

TAG=$(git tag)


DEBFILE_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}/${PACKAGE}"
REPOSITORY="./docs/debian"

echo "GITHUB_EVENT_PATH: ${GITHUB_EVENT_PATH}"
echo "GITHUB_REF: ${GITHUB_REF}"
echo "PACKAGE: ${PACKAGE}"
echo "CODENAME: ${CODENAME}"
echo "DEBFILE_URL: ${DEBFILE_URL}"
echo "REPOSITORY: ${REPOSITORY}"
OUTPUT=$(ls)

#wget ${DEBFILE_URL}
wget https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_amd64.deb
echo "Directory list:\n${OUTPUT}"
#reprepro --basedir ${REPOSITORY} includedeb ${CODENAME} ${PACKAGE}
