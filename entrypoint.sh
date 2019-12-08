#!/bin/bash

TAG=$(git tag | sort -V | tail -1)
VERSION="${TAG:1}"
PACKAGE="${NAME}_${VERSION}_${OS}_${ARCH}.deb"
DEBFILE_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}/${PACKAGE}"

# for development only
#DEBFILE_URL="https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_amd64.deb"

echo "TAG: ${TAG}"
echo "PACKAGE: ${PACKAGE}"
echo "CODENAME: ${CODENAME}"
echo "REPOSITORY: ${REPOSITORY}"
echo "DEBFILE_URL: ${DEBFILE_URL}"

echo "Fetching Debian package ${DEBFILE_URL}"
wget -q ${DEBFILE_URL}

echo "Creating Debian Repository"
reprepro --basedir ${REPOSITORY} includedeb ${CODENAME} *.deb

git config --global user.name ${GITHUB_ACTOR}
git config --global user.email "${GITHUB_ACTOR}@gmail.com"

echo "Checkout master"
git checkout master

echo "Adding ${REPOSITORY} to master"
git add --all ${REPOSITORY}

echo "Commit repository"
git commit -m "Added Debian Repository to master"

echo "Push repository to master"
#git push -u origin master         
git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
