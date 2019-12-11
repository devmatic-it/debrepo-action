# DEBREPO Github action

This action creates a private Debian Repository using Github pages.

## Evironment Variables

### `GITHUB_TOKEN`

**Required** GitHub OAUTH2 TOKEN, should be set to ${{secrets.GITHUB_TOKEN}}

### REPOSITORY

**Required** path in the master branch where to store the GitHub pages. It is recommended to use the following path './docs/debian'

### `NAME`

**Required** name of the debian package, for example 'debcvescan'

### `ARCH`

**Required**  CPU architecture to use, for example 'amd64'

### `OS`

**Required** Operating system to use, for example 'linux'

### `CODENAME`

**Required** Debian release code name for example 'buster'

### `PRIVATE_KEY`

**Required** Private GPG key used to sign the Debian packages

## Create and distribute GPG keys

1. Create private key without password `gpg --gen-key`
2. Export key without password `gpg –output PUBLIC.KEY –armor –export <email_of_key>`
3. Export private key: `gpg –output PRIVATE.KEY –armor –export-secret-key <email_of_key>`
4. Create GitHub secrets `PUBLIC_KEY` and paste content of PUBLIC.KEY file. See details in <https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets>
5. Create GitHub secrets `PRIVATE_KEY` and paste content of PRIVATE.KEY file. See details in <https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets>

## Example usage

name: DebianRepository
on: [push]

jobs:
  release:
    name: Release on GitHub
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: Create Debian repository test
        uses: ./
        env:
          GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
          PRIVATE_KEY: ${{secrets.PRIVATE_KEY}}
          PUBLIC_KEY: ${{secrets.PUBLIC_KEY}}
          REPOSITORY: './docs/debian'
          NAME: 'debcvescan'
          ARCH: 'amd64'
          OS: 'linux'
          CODENAME: 'buster'

## Credits

- Creating GutHub Actions with Docker <https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-a-docker-container-action>
- article <https://pmateusz.github.io/linux/2017/06/30/linux-secure-apt-repository.html>
- Wiki <https://wiki.debian.org/DebianRepository/SetupWithReprepro>