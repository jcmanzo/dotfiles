# Description

Collection of personal dotfiles, environment settings and tools that I like to use to keep my development environments in sync.

# Install

## Default

Clone repo and run `./install.sh` script. The `-f` flag can be passed to re-install everything.

## Using Curl

```bash
curl -sSL https://raw.githubusercontent.com/jcmanzo/dotfiles/master/install.sh | bash
```

To re-install

```bash
curl -sSL https://raw.githubusercontent.com/jcmanzo/dotfiles/master/install.sh | bash -s -- -f
```

# Changing Shells

The dotfiles in this repo are speficially for the ZSH shell. If installed, run `sudo chsh "$(id -un)" --shell "/usr/bin/zsh` to change your default shell. Otherwise ZSH must be installed first by following these steps https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default
