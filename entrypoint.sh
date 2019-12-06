#!/bin/sh -l

PACKAGE=$1
CODENAME="buster"
DEBFILE_URL="https://github.com/{GITHUB_REPOSITORY}/releases/releases/download/${GITHUB_REF}/${PACKAGE}"

echo "PACKAGE is ${PACKAGE}"
echo "CODENAME is ${CODENAME}"
echo "DEBFILE_URL is ${DEBFILE_URL}"

#reprepro --basedir REPOSITORY.PATH includedeb ${CODENAME} ${PACKAGE}
