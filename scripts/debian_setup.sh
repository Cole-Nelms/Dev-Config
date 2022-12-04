

#----------------------------------------------------------------------
#
#  This script upgrades debian to unstable,
#  installs packages, and configures the system.
#
#  Just run with no arguments. Make sure
#  to run as root or with sudo, since this is
#  a system wide configuration.
#
#----------------------------------------------------------------------


#!/bin/sh

# Update apt sources to unstable, and install packages.
#----------------------------------------------------------------------

cat > /etc/apt/sources.list << \
--
deb http://deb.debian.org/debian/ unstable main non-free contrib
deb-src http://deb.debian.org/debian/ unstable main non-free contrib
--

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

# Install i3.
#----------------------------------------------------------------------

git clone https://www.github.com/Airblader/i3 /opt/i3

mkdir /opt/i3/build && cd /opt/i3/build
meson .. && ninja

# Get repository directory.
#----------------------------------------------------------------------

REPO=$(dirname ${0}) && cd ${REPO} && cd .. && REPO=$PWD

# Configure system.
#----------------------------------------------------------------------

link () {
  local DIR=$(dirname ${2})
  mkdir --parent ${DIR} && rm --recursive --force ${2}

  ln --symbolic --force ${1} ${2}
}

link ${REPO}/system/grub /etc/default/grub

os-prober
update-grub
