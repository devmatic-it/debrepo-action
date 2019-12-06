# DEBREPO Github action

This action creates a private Debian Repository using Github pages.

## Inputs

### `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

### `time`

The time we greeted you.

## Example usage

uses: actions/hello-world-docker-action@v1
with:
  who-to-greet: 'Mona the Octocat'

## Credits

- article <https://pmateusz.github.io/linux/2017/06/30/linux-secure-apt-repository.html>
- Wiki <https://wiki.debian.org/DebianRepository/SetupWithReprepro>