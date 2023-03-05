
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
    link \${REPO}/user/.bashrc \${HOME}/.bashrc
    link \${REPO}/user/.vimrc  \${HOME}/.vimrc
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
apt update && apt install -y --no-install-recommends \
    firmware-linux-nonfree     \
    firmware-misc-nonfree      \
    firmware-iwlwifi           \
    firmware-realtek           \
                               \
    network-manager            \
    alsa-utils                 \
    software-properties-common \
    sudo                       \
    rsync                      \
    curl                       \
    vim                        \
    git                        \
    man-db                     \
    fuse                       \
    os-prober                  \
    tree                       \
    python3-pip                \
                               \
    xinit                      \
    x11-utils                  \
    xorg                       \
    i3                         \
                               \
    kitty                      \
    feh                        \
    firefox

# create symlinks
default_links
link \${REPO}/system/grub              /etc/default/grub
link \${REPO}/scripts/upgrade.sh       /usr/local/bin/upgrade.sh
link \${REPO}/scripts/cleanup.sh       /usr/local/bin/cleanup.sh
link \${REPO}/scripts/start_polybar.sh /usr/local/bin/start_polybar.sh

chmod +x /usr/local/bin/upgrade.sh
chmod +x /usr/local/bin/cleanup.sh
chmod +x /usr/local/bin/start_polybar.sh

# update bootloader
os-prober
update-grub

----------------------------------------------------------------------------------------------

. ./utils.sh

# setup root user, and system configuration
su --login --command "sh ${PWD}/sys.sh"

# create symlinks
default_links
link ${REPO}/user/.xinitrc   ${HOME}/.xinitrc
link ${REPO}/user/wallpapers ${HOME}/Pictures/Wallpapers
link ${REPO}/user/i3         ${HOME}/.config/i3
link ${REPO}/user/rofi       ${HOME}/.config/rofi
link ${REPO}/user/polybar    ${HOME}/.config/polybar
link ${REPO}/user/kitty      ${HOME}/.config/kitty
link ${REPO}/user/alacritty  ${HOME}/.config/alacritty

# install Ansible
python3 -m pip install --user ansible 

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install Node Version Manager, and Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

. ~/.bashrc
nvm install node

# install rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-watch alacritty bottom

# cleanup generated files
rm sys.sh utils.sh
