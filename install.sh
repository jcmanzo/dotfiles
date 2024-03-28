#!/bin/bash
# Note: This installation script assumes a macOS or Debian-based system.

EMOJI_NEWLINE=" →"
OS=$(uname -s)

OMZ_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
OMZ_CUSTOM_PLUGINS="$OMZ_CUSTOM/plugins"
OMZ_CUSTOM_THEMES="$OMZ_CUSTOM/themes"
OMZ_THEME_NAME="honukai.zsh-theme"

init_pkg_manager () {
  echo "$EMOJI_NEWLINE Initializing pkg manager"

  if [ "$OS" == "Darwin" ]; then
    # If Darwin, install Homebrew
    if ! [ -x "$(command -v brew)" ]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo " $EMOJI_NEWLINE Installed Homebrew"
    fi
    echo "  $EMOJI_NEWLINE Updating Homebrew"
    brew update 1> /dev/null
  else
    echo "linux"
    sudo apt-get update
  fi
}

init_pkgs () {
  declare -a StringArray=("zsh" "autojump")
  echo "$EMOJI_NEWLINE Initializing packages"
  for pkg in ${StringArray[@]}; do
    if [ "$OS" == "Darwin" ]; then
      if ! [ -x "$(command -v $pkg)" ]; then
        brew install $pkg 1> /dev/null
        echo " $EMOJI_NEWLINE Installed $pkg"
      fi
    else
      if ! [ -x "$(command -v $pkg)" ]; then
        sudo apt-get install $pkg -y 1> /dev/null
        echo " $EMOJI_NEWLINE Installed $pkg"
      fi
    fi
  done
}

init_oh_my_zsh() {
  # Install oh-my-zsh
  echo "$EMOJI_NEWLINE Initializing oh-my-zsh"
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "  $EMOJI_NEWLINE Detected installed oh-my-zsh framework"
  else
    /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "  $EMOJI_NEWLINE Installed oh-my-zsh framework"
  fi

  # Install extra oh-my-zsh plugins
  declare -a StringArray=("zsh-autosuggestions" "zsh-syntax-highlighting")
  echo "  $EMOJI_NEWLINE Installing zsh plugins"
  for plugin in ${StringArray[@]}; do
    if [ -d $OMZ_CUSTOM_PLUGINS/$plugin ]; then
      echo "    $EMOJI_NEWLINE Detected installed '$plugin' plugin."
    else
      git clone --quiet "https://github.com/zsh-users/$plugin" $OMZ_CUSTOM_PLUGINS/$plugin
      echo "    $EMOJI_NEWLINE Installed $plugin"
    fi
  done
}

init_dotfiles() {
  echo "$EMOJI_NEWLINE Initializing dot files"
  declare -a StringArray=(".zshrc" ".vimrc" ".tmux.conf")
  for file in ${StringArray[@]}; do
    if [ -f $HOME/$file ]; then
      echo "  $EMOJI_NEWLINE Detected '$file' file. Backing up to $HOME/$file.bak"
      cp -n $HOME/$file{,.bak}
      rm $HOME/$file
    fi

    ln -s $(pwd)/files/$file $HOME/$file
    echo "  $EMOJI_NEWLINE Copied over $file"
  done
}

init_custom_omzsh() {
   # Install my custom plugins
   # Loop over and copy files in files/.oh-my-zsh/custom/plugins/jc-git
    echo "$EMOJI_NEWLINE Initializing custom plugins"
    declare -a StringArray=("git")
    for plugin in ${StringArray[@]}; do
      if [ -d $OMZ_CUSTOM_PLUGINS/$plugin ]; then
        echo "  $EMOJI_NEWLINE Detected installed '$plugin' plugin."
      else
        cp -rn $(pwd)/files/.oh-my-zsh/custom/plugins/$plugin $OMZ_CUSTOM_PLUGINS/$plugin
      fi
    done

	  echo "$EMOJI_NEWLINE Installing latest custom Honukai theme..."
    cp -rn $(pwd)/files/.oh-my-zsh/custom/themes/$OMZ_THEME_NAME $OMZ_CUSTOM_THEMES/$OMZ_THEME_NAME
}

init_pkg_manager
init_pkgs
init_oh_my_zsh
init_dotfiles
init_custom_omzsh
