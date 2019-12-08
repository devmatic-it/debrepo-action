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
echo "GITHUB_ACTOR: ${GITHUB_ACTOR}" 
echo "GITHUB_TOKEN: ${GITHUB_TOKEN}"

#wget ${DEBFILE_URL}
wget -q https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_amd64.deb


echo "Creating Debian Repository"
reprepro --basedir ${REPOSITORY} includedeb ${CODENAME} ${PACKAGE}

OUTPUT=$(ls -la)
echo ${OUTPUT}

git add ${REPOSITORY}
git commit -m "Added Debian Repository to master"
git push -u origin master
