#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
base_path="$(dirname "$0")"             # Script location
bkp_dir=~/dotfiles_bkp                  # Dotfiles backup directory
omz_custom_dir=.oh-my-zsh/custom        # Oh-my-zsh custom directory 
plugins_path=$omz_custom_dir/plugins    # Oh-my-zsh plugins directory
dotfiles="vimrc zshrc gitconfig"        # list of files/folders to symlink in homedir
##########

# Go to the Oh-my-zsh plugins directory
cd $base_path/$plugins_path

# Download submodules
echo "Downloading submodules"
for d in */ ; do
    [ -L "${d%/}" ] && continue # ignore symlinks
    cd $d && git submodule upgrade --init --recurse && cd ..
done

# Replace zshrc.sh file with custom git prompt
cat zsh-git-prompt-custom-zshrc.sh > zsh-git-prompt/zshrc.sh

# Create oh-my-zsh custom symlink
echo "Creating Oh-my-zsh custom symlink"
ln -s $base_path/$omz_custom_dir ~$USER/$omz_custom_dir

echo "Creating $bkp_dir for backup of any existing dotfiles in ~"
mkdir -p $bkp_dir

# change to the dotfiles directory
echo "Changing directory to " ~$USER
cd ~$USER

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~$USER to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $base_path/.$file ~/.$file
done


