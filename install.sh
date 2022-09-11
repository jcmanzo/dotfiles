#!/bin/bash

# Sets the default editor for all programs to Vim
export VISUAL=vim
export EDITOR="$VISUAL"

# Install brew if required
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "✅ Brew not found. Installing 🍺..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Brew is installed"
    echo -n "Updating 🍺..."
    brew update
fi

# Install Z shell if required
which -s zsh
if [[ $? != 0 ]] ; then
    echo "✅ Z shell not found. Installing 🆉..."
    brew install zsh
else
   echo "✅ Z shell is installed"

fi

# Install Oh My Zsh framekwork if required
if [ -d ~/.oh-my-zsh ]; then
	echo "✅ Oh My Zsh is installed"
 else
 	echo "Oh My Zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Oh My Zsh plugins
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
	echo "✅ Zsh Autosuggestions is installed"
 else
 	echo "Oh My Zsh not found. Installing..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
