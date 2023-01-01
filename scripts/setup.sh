
#!/bin/sh

cd $(dirname ${0})

# generate script for functions, and variables
cat > utils.sh << \
----------------------------------------------------------------------------------------------

#!/bin/sh

# repo directory
cd .. && REPO=\${PWD} && cd scripts

# create links
link () {
    local DIR=\$(dirname \${2})
    mkdir --parent \${DIR} && rm --recursive --force \${2}

    ln --symbolic --force \${1} \${2}
}

# setup default symlinks
default_links () {
    link \${REPO}/user/.bashrc  \${HOME}/.bashrc
    link \${REPO}/user/.vimrc   \${HOME}/.vimrc
    link \${REPO}/user/nvim     \${HOME}/.config/nvim
}

# setup vim/neovim plugins
setup_vim () {
    # install vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    sh -c 'curl -fLo "\${XDG_DATA_HOME:-\$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # install packer.nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

# install node version manager, and node
install_node () {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

    . ~/.bashrc
    nvm install node
}

----------------------------------------------------------------------------------------------

# generate script for system config, and root setup
cat > sys.sh << \
----------------------------------------------------------------------------------------------

#!/bin/sh

cd \$(dirname \${0}) && . ./utils.sh

# update apt sources to unstable
cat > /etc/apt/sources.list << \
EOM
deb http://deb.debian.org/debian/ unstable main non-free contrib
deb-src http://deb.debian.org/debian/ unstable main non-free contrib
EOM

# install apt packages
apt update && apt install -y   \
  firmware-linux-nonfree       \
  firmware-misc-nonfree        \
  firmware-iwlwifi             \
  firmware-realtek             \
                               \
  network-manager              \
  alsa-utils                   \
  software-properties-common   \
  sudo                         \
  rsync                        \
  curl                         \
  vim                          \
  git                          \
  man-db                       \
  fuse                         \
  os-prober                    \
  tree                         \
  python3-pip                  \
                               \
  xinit                        \
  x11-utils                    \
  xorg                         \
                               \
  dh-autoreconf                \
  libxcb-keysyms1-dev          \
  libpango1.0-dev              \
  libxcb-util0-dev             \
  xcb                          \
  libxcb1-dev                  \
  libxcb-icccm4-dev            \
  libyajl-dev                  \
  libev-dev                    \
  libxcb-xkb-dev               \
  libxcb-cursor-dev            \
  libxkbcommon-dev             \
  libxcb-xinerama0-dev         \
  libxkbcommon-x11-dev         \
  libstartup-notification0-dev \
  libxcb-randr0-dev            \
  libxcb-xrm0                  \
  libxcb-xrm-dev               \
  libxcb-shape0                \
  libxcb-shape0-dev            \
  meson                        \
                               \
  kitty                        \
  feh                          \
  firefox

# install i3wm
git clone https://www.github.com/Airblader/i3 /opt/i3
mkdir /opt/i3/build && cd /opt/i3/build
meson .. && ninja

# install neovim
curl --location --output /usr/local/nvim \
    https://github.com/neovim/neovim/releases/download/v0.8.0/nvim.appimage

chmod 770 /usr/local/bin/nvim

# install node version manager, and node
install_node

# vim/neovim plugins
setup_vim

# create symlinks
default_links
link \${REPO}/scripts/custom_polybar /usr/local/bin/custom_polybar
link \${REPO}/system/grub            /etc/default/grub

chmod +x /usr/local/bin/custom_polybar

# update bootloader
os-prober
update-grub

----------------------------------------------------------------------------------------------

. ./utils.sh

# setup root user, and system configuration
su --login --command "sh ${PWD}/sys.sh"

# install ansible
python3 -m pip install --user ansible 

# install node version manager, and node
install_node

# vim/neovim plugins
setup_vim

# create symlinks
default_links
link ${REPO}/user/.xinitrc   ${HOME}/.xinitrc
link ${REPO}/user/wallpapers ${HOME}/Pictures/Wallpapers
link ${REPO}/user/i3         ${HOME}/.config/i3
link ${REPO}/user/rofi       ${HOME}/.config/rofi
link ${REPO}/user/polybar    ${HOME}/.config/polybar
link ${REPO}/user/kitty      ${HOME}/.config/kitty

# cleanup generated files
rm sys.sh utils.sh
