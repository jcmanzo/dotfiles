#!/bin/bash

# Install Z shell if required
which zsh 1> /dev/null
if [[ $? != 0 ]] ; then
   echo "❗️ Z shell not found. Install before proceeding."
else
   echo "✅ Z shell is installed"
fi

# Install Oh My Zsh framekwork if required
if [ -d "$ZSH" ] ; then
  echo "✅ Oh My Zsh is installed"
else
  echo "⬇ Oh My Zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Oh My Zsh plugins
OMZ_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
OMZ_CUSTOM_PLUGINS="$OMZ_CUSTOM/plugins"
OMZ_CUSTOM_THEMES="$OMZ_CUSTOM/themes"

# Force flag to reinstall plugins and configurations.
force=false
while getopts "f" opt; do
  if [ $opt == "f" ]; then
    force=true
    echo "♻️ Flag -f provided, plugins and configs will be reinstalled."
    rm -rf $OMZ_CUSTOM
  fi
done

if [ -d $OMZ_CUSTOM_PLUGINS/zsh-autosuggestions ]; then
	echo "✅ Zsh Autosuggestions is installed"
 else
 	echo "⬇ Zsh Autosuggestions not found. Installing..."
    git clone --quiet https://github.com/zsh-users/zsh-autosuggestions $OMZ_CUSTOM_PLUGINS/zsh-autosuggestions
fi
if [ -d $OMZ_CUSTOM_PLUGINS/zsh-syntax-highlighting ]; then
	echo "✅ Zsh Syntax Highlighting is installed"
 else
 	echo "⬇ Zsh Syntax Highlighting not found. Installing..."
    git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ_CUSTOM_PLUGINS/zsh-syntax-highlighting
fi

if [ -d $OMZ_CUSTOM_PLUGINS/jc-git ]; then
	echo "✅ Git aliases is installed"
else
    echo "⬇ Git aliases not found. Installing..."
    curl -fLo $OMZ_CUSTOM_PLUGINS/jc-git/jc-git.plugin.zsh --create-dirs --silent \
        https://raw.githubusercontent.com/jcmanzo/dotfiles/master/.oh-my-zsh/custom/plugins/jc-git/jc-git.plugin.zsh

    curl -fLo $OMZ_CUSTOM_PLUGINS/jc-git/git-prompt.sh --silent \
        https://raw.githubusercontent.com/jcmanzo/dotfiles/master/.oh-my-zsh/custom/plugins/jc-git/git-prompt.sh
fi

if [ -f $OMZ_CUSTOM/themes/honukai.zsh-theme ]; then
	echo "✅ Honukai theme is installed"
else
    echo "⬇ Honukai theme not found. Installing..."
    curl -fLo $OMZ_CUSTOM/themes/honukai.zsh-theme --create-dirs --silent \
        https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme
fi

# Install Vim plugin manager
if [ -f ~/.vim/autoload/plug.vim ]; then
	echo "✅ Vim plugin manager is installed"
 else
 	echo "⬇ Vim plugin manager not found. Installing..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs --silent \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "✅ Updating .vimrc"
curl -fLo ~/.vimrc --silent \
        https://raw.githubusercontent.com/jcmanzo/dotfiles/master/.vimrc
