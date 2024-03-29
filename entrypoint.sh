#!/bin/bash
# Package dpkg Debian Package Manager Interface
# Copyright 2019 debcvescan authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TAG=$(git tag | sort -V | tail -1)
VERSION="${TAG:1}"
PACKAGE_AMD64="${NAME}_${VERSION}_${OS}_amd64.deb"
PACKAGE_I386="${NAME}_${VERSION}_${OS}_i386.deb"
DEBFILE_AMD64_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}/${PACKAGE_AMD64}"
DEBFILE_I386_URL="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}/${PACKAGE_I386}"

# for development only
if [[ -v TESTING ]]; then
    echo "TESTING ONLY!!!"
    DEBFILE_AMD64_URL="https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_amd64.deb"  
    DEBFILE_I386_URL="https://github.com/devmatic-it/debcvescan/releases/download/v0.1.10/debcvescan_0.1.10_linux_i386.deb"
fi

GIT_PAGES_OWNER=`echo "${GITHUB_REPOSITORY}" | awk -F "/" '{print $1}'`
GIT_PAGES_PATH=`echo "${GITHUB_REPOSITORY}" | awk -F "/" '{print $2}'`
GIT_PAGES_URL="${GIT_PAGES_OWNER}.github.io/${GIT_PAGES_PATH}/debian"

echo "TAG: ${TAG}"
echo "PACKAGE: ${PACKAGE}"
echo "CODENAME: ${CODENAME}"
echo "REPOSITORY: ${REPOSITORY}"
echo "DEBFILE_AMD64_URL: ${DEBFILE_AMD64_URL}"
echo "DEBFILE_I386_URL: ${DEBFILE_I386_URL}"
echo "GIT_PAGES_URL: ${GIT_PAGES_URL}"

git config --global user.name ${GITHUB_ACTOR}
git config --global user.email "${GITHUB_ACTOR}@gmail.com"

echo "Checkout master"
git checkout master

echo "Reset repository directory"
rm -Rf ${REPOSITORY}
mkdir -p ${REPOSITORY}
mkdir -p ${REPOSITORY}/conf

echo "Importing public key from environment variable"
echo "${PUBLIC_KEY}" | gpg --import
echo "${PUBLIC_KEY}" > ${REPOSITORY}/PUBLIC.KEY

echo "Importing private key from environment variable"
echo "${PRIVATE_KEY}" | gpg --import
KEY_ID=`gpg -K --with-colons | awk -F ":" '{if (length($8) >0)print $8}'`
echo "Using KEY.ID ${KEY_ID}"

echo "Creating Repository distributions file"
echo "Origin: ${GIT_PAGES_URL}" > ${REPOSITORY}/conf/distributions
echo "Label: ${GIT_PAGES_URL}" >> ${REPOSITORY}/conf/distributions
echo "Codename: ${CODENAME}" >> ${REPOSITORY}/conf/distributions
echo "Architectures: i386 amd64" >> ${REPOSITORY}/conf/distributions
echo "Components: main" >> ${REPOSITORY}/conf/distributions
echo "Description: Personal repository" >> ${REPOSITORY}/conf/distributions
echo "SignWith: default" >> ${REPOSITORY}/conf/distributions

echo "Fetching Debian packages"
wget -q ${DEBFILE_AMD64_URL}
wget -q ${DEBFILE_I386_URL}

echo "Creating Debian Repository"
reprepro --basedir ${REPOSITORY} includedeb ${CODENAME} *.deb
(($? != 0)) && { printf '%s\n' "ERROR: An error occured creating the repostory"; exit 1; }

echo "Adding ${REPOSITORY} to master"
git add --all ${REPOSITORY}

echo "Commit repository"
git commit -m "Added Debian Repository to master"

echo "Push repository to master"
#git push -u origin master         
git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
