#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
base_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"    # Script location
bkp_dir=~/dotfiles_bkp                  # Dotfiles backup directory
omz_custom_dir=.oh-my-zsh/custom        # Oh-my-zsh custom directory 
plugins_path=$omz_custom_dir/plugins    # Oh-my-zsh plugins directory
dotfiles=(vimrc zshrc gitconfig profile zprofile)        # list of files/folders to symlink in homedir
##########

# Go to the Oh-my-zsh plugins directory
cd $base_path/$plugins_path

echo "Downloading submodules"
for d in */ ; do
    [ -L "${d%/}" ] && continue # ignore symlinks
    cd $d && git submodule update --init --recursive && cd ..
done

# Replace zshrc.sh file with custom git prompt
cat zsh-git-prompt-custom-zshrc.sh > zsh-git-prompt/zshrc.sh

echo "Creating Oh-my-zsh custom symlink"
mv ~/$omz_custom_dir ~/"$omz_custom_dir"_bkp
ln -sf $base_path/$omz_custom_dir ~/$omz_custom_dir

echo "Creating $bkp_dir for backup of any existing dotfiles in ~"
mkdir -p $bkp_dir

echo "Changing directory to ~"
cd ~

echo "Moving existing dotfiles from ~ to $bkp_dir"
for file in $dotfiles; do
	if [ -f "$file" ]; then
    	mv ~/.$file $bkp_dir
	fi
    echo "Creating symlink to $file in home directory."
    echo "$base_path/.$file"
    ln -sf $base_path/.$file ~/.$file
done

echo "Downloading zsh plugins" 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/softmoth/zsh-vim-mode.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vim-mode

echo "Downloading dependencies"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

echo "Installing vim plugins"
vim +PlugInstall +qall

echo "Loading environment variables"
source ~/.profile
source ~/.zprofile

echo "Reloading zsh"
source ~/.zshrc

