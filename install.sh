#!/bin/bash
# Note: This installation script assumes a macOS or Debian-based system.

EMOJI_NEWLINE=" →"
OS=$(uname -s)

OMZ_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
OMZ_CUSTOM_PLUGINS="$OMZ_CUSTOM/plugins"
OMZ_CUSTOM_THEMES="$OMZ_CUSTOM/themes"
OMZ_THEME_NAME="honukai_modified.zsh-theme"

GH_DOTFILES_RAW="https://raw.githubusercontent.com/jcmanzo/dotfiles/main/files"

# Check user flag "p" for option to use remote dotfiles
while getopts "r" opt; do
  case $opt in
    r)
      echo "$EMOJI_NEWLINE Using remote dotfiles"
      REMOTE_DOTFILES=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

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
    sudo apt-get update
  fi
}

install_pkgs () {
  declare -a StringArray=("zsh" "autojump" "tldr" "fzf")
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

    if [ "$REMOTE_DOTFILES" = true ]; then
      helper_download_file $file "$HOME/$file"
    else
      ln -fs $(pwd)/files/$file "$HOME/$file"
    fi

    echo "  $EMOJI_NEWLINE Copied over $file"
  done
}

init_custom_omzsh() {
   # Install my custom plugins
   # Loop over and copy files in files/oh-my-zsh/custom/plugins/jc-git
    echo "$EMOJI_NEWLINE Initializing custom oh-my-zsh plugins"
    declare -a StringArray=("git")
    for plugin in ${StringArray[@]}; do
      if [ -d $OMZ_CUSTOM_PLUGINS/$plugin ]; then
        echo "  $EMOJI_NEWLINE Detected installed '$plugin' plugin."
      else
        cp -rn $(pwd)/files/oh-my-zsh/custom/plugins/$plugin "$OMZ_CUSTOM_PLUGINS/$plugin"
      fi
    done

	  echo "$EMOJI_NEWLINE Installing latest custom Honukai theme"
    if [ "$REMOTE_DOTFILES" = true ]; then
      helper_download_file "oh-my-zsh/custom/themes/$OMZ_THEME_NAME" "$OMZ_CUSTOM_THEMES/$OMZ_THEME_NAME"
    else
      cp -rfn $(pwd)/files/oh-my-zsh/themes/$OMZ_THEME_NAME "$OMZ_CUSTOM_THEMES/$OMZ_THEME_NAME"
    fi
}

init_vim_plugin_manager() {
  # Install Vim plugin manager
  if [ -f ~/.vim/autoload/plug.vim ]; then
    echo "$EMOJI_NEWLINE Detected installed Vim plugin manager."
  else
    echo "$EMOJI_NEWLINE Installing Vim plugin manager."
      curl -fLo ~/.vim/autoload/plug.vim --create-dirs --silent \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

helper_download_file() {
  echo "  $EMOJI_NEWLINE Downloading file: $1"
  echo " DEBUG ---- $GH_DOTFILES_RAW/$1 > $2"
  curl -sSL $GH_DOTFILES_RAW/$1 > $2
}

init_pkg_manager
install_pkgs
init_oh_my_zsh
init_dotfiles
init_custom_omzsh
init_vim_plugin_manager
