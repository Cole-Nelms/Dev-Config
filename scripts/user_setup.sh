

#----------------------------------------------------------------------
#
#  This script setups/configures, various software.
#
#  Just run with no arguments as the intended user.
#  If the intended user is not root, then make sure
#  to not run as root or with sudo.
#
#----------------------------------------------------------------------


#!/bin/sh

# Get repository directory.
#----------------------------------------------------------------------

REPO=$(dirname ${0}) && cd ${REPO} && cd .. && REPO=$PWD

# Symlink repository into home directory.
#----------------------------------------------------------------------

link () {
  local DIR=$(dirname ${2})
  mkdir --parent ${DIR} && rm --recursive --force ${2}

  ln --symbolic --force ${1} ${2}
}
 
link ${REPO}/user/.bashrc  ${HOME}/.bashrc
link ${REPO}/user/.vimrc   ${HOME}/.vimrc
link ${REPO}/user/.xinitrc ${HOME}/.xinitrc

link ${REPO}/user/wallpapers ${HOME}/Pictures/Wallpapers
link ${REPO}/user/i3         ${HOME}/.config/i3
link ${REPO}/user/rofi       ${HOME}/.config/rofi
link ${REPO}/user/polybar    ${HOME}/.config/polybar
link ${REPO}/user/kitty      ${HOME}/.config/kitty
link ${REPO}/user/nvim       ${HOME}/.config/nvim

# Install Ansible.
#----------------------------------------------------------------------

python3 -m pip install --user ansible

# Install Node Version Manager.
#----------------------------------------------------------------------

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# Install Neovim.
#----------------------------------------------------------------------

LOCAL_BIN="${HOME}/.local/bin"
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.8.0/nvim.appimage"

mkdir --parent ${LOCAL_BIN}
curl --location --output ${LOCAL_BIN}/nvim ${NEOVIM_URL}
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
