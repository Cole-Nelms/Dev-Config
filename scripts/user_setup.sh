

#----------------------------------------------------------------------
#
#  This script setups/configures, various software.
#
#  Just run with no arguments as the intended user.
#  If the intended user is not root, then make sure
#  to not run as root or with sudo.
#
#----------------------------------------------------------------------


#!/bin/bash

# Install Neovim.
#----------------------------------------------------------------------

LOCAL_BIN="${HOME}/.local/bin"

mkdir --parent ${LOCAL_BIN}
curl -L https://github.com/neovim/neovim/releases/download/v0.8.0/nvim.appimage > ${LOCAL_BIN}/nvim
chmod 770 ${LOCAL_BIN}/nvim

# Install vim-plug for Vim/NeoVim.
#----------------------------------------------------------------------

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install packer.nvim for NeoVim.
#----------------------------------------------------------------------

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install Node Version Manager
#----------------------------------------------------------------------

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# Install configuration repository, and copy it into home directory.
#----------------------------------------------------------------------

mkdir --parent ~/.config ~/Repos && cd ~/Repos
git clone https://github.com/Cole-Nelms/linux_config.git

REPO="${HOME}/Repos/linux_config"
REPO_CFG="${REPO}/.config"
HOME_CFG="${HOME}/.config"

rm -rf ${HOME_CFG}/i3
ln -sf ${REPO_CFG}/i3 ${HOME_CFG}/i3

rm -rf ${HOME_CFG}/kitty
ln -sf ${REPO_CFG}/kitty ${HOME_CFG}/kitty

rm -rf ${HOME_CFG}/nvim
ln -sf ${REPO_CFG}/nvim ${HOME_CFG}/nvim

ln -sf ${REPO}/.bashrc ${HOME}/.bashrc
ln -sf ${REPO_CFG}/nvim/init.vim ${HOME}/.vimrc
