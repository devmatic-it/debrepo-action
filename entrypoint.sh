#!/bin/bash

TAG=$(git tag | sort -V | tail -1)
VERSION="${TAG:1}"
PACKAGE="${NAME}_${VERSION}_${OS}_${ARCH}.deb"
DEBFILE_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}/${PACKAGE}"

# for development only
DEBFILE_URL="https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_amd64.deb"

echo "TAG: ${TAG}"
echo "PACKAGE: ${PACKAGE}"
echo "CODENAME: ${CODENAME}"
echo "REPOSITORY: ${REPOSITORY}"
echo "DEBFILE_URL: ${DEBFILE_URL}"

echo "Importing GPG keys from environment variables"
echo -e "${PUBLIC_KEY}" | gpg --import
echo -e "${PRIVATE_KEY}" | gpg --import
echo -e "${PUBLIC_KEY}" > ${REPOSITORY}/PUBLIC.KEY

echo "Creating Resitory conf file"
echo "Origin: devmatic-it.github.io/debrepo-action/debian" > ${REPOSITORY}/conf/distributions
echo "Label: devmatic-it.github.io/debrepo-action/debian" >> ${REPOSITORY}/conf/distributions
echo "Codename: ${CODENAME}" >> ${REPOSITORY}/conf/distributions
echo "Architectures: ${ARCH}" >> ${REPOSITORY}/conf/distributions
echo "Components: main" >> ${REPOSITORY}/conf/distributions
echo "Description: Personal repository" >> ${REPOSITORY}/conf/distributions
echo "SignWith: default" >> ${REPOSITORY}/conf/distributions

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
