#!/bin/bash

# Install Z shell if required
which zsh
if [[ $? != 0 ]] ; then
    echo "❗️ Z shell not found. Install before proceeding."
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
 	echo "Zsh Autosuggestions not found. Installing..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
	echo "✅ Zsh Syntax Highlighting is installed"
 else
 	echo "Zsh Syntax Highlighting not found. Installing..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/jc-git ]; then
	echo "✅ Git aliases is installed"
else
    echo "Git aliases not found. Installing..."
    curl -fLo ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/jc-git/jc-git.plugin.zsh --create-dirs \
        https://raw.githubusercontent.com/jcmanzo/dotfiles/master/.oh-my-zsh/jc-git/jc-git.plugin.zsh
fi

if [ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/honukai.zsh-theme ]; then
	echo "✅ Honukai theme is installed"
else
    echo "Honukai theme not found. Installing..."
    curl -fLo ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/honukai.zsh-theme --create-dirs \
        https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme
fi

# Install Vim plugin manager
if [ -f ~/.vim/autoload/plug.vim ]; then
	echo "✅ Vim plugin manager is installed"
 else
 	echo "Vim plugin manager not found. Installing..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
