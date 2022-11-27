

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


#!/bin/bash

# Get repository directory.
#----------------------------------------------------------------------

REPO=$(dirname $0) && cd ${REPO} && cd .. && REPO=$(pwd)

# Update apt sources to unstable, and install packages.
#----------------------------------------------------------------------

echo "deb http://deb.debian.org/debian/ unstable main non-free contrib"      > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ unstable main non-free contrib" >> /etc/apt/sources.list
apt update

PACKAGES=(
  # Firmware
  "firmware-linux-nonfree"
  "firmware-misc-nonfree"
  "firmware-iwlwifi"
  "firmware-realtek"

  # System utilities
  "network-manager"
  "alsa-utils"
  "software-properties-common"
  "sudo"
  "rsync"
  "curl"
  "vim"
  "git"
  "man-db"
  "fuse"
  "os-prober"
  "tree"
  "python3-pip"

  # Display server
  "xinit"

  # i3-gaps
  "dh-autoreconf"
  "libxcb-keysyms1-dev"
  "libpango1.0-dev"
  "libxcb-util0-dev"
  "xcb"
  "libxcb1-dev"
  "libxcb-icccm4-dev"
  "libyajl-dev"
  "libev-dev"
  "libxcb-xkb-dev"
  "libxcb-cursor-dev"
  "libxkbcommon-dev"
  "libxcb-xinerama0-dev"
  "libxkbcommon-x11-dev"
  "libstartup-notification0-dev"
  "libxcb-randr0-dev"
  "libxcb-xrm0"
  "libxcb-xrm-dev"
  "libxcb-shape0"
  "libxcb-shape0-dev"
  "meson"
  "ninja"

  # Apps
  "kitty"
  "feh"
  "firefox"
)

for i in ${!PACKAGES[@]}; do
  apt install ${PACKAGES[$i]} -y
done

# Install i3-gaps.
#----------------------------------------------------------------------

git clone https://www.github.com/Airblader/i3 /opt/i3-gaps && cd /opt/i3-gaps

mkdir -p build && cd build
meson ..
ninja

# Configure system.
#----------------------------------------------------------------------

link () {
  local DIR=$(dirname ${2})
  mkdir --parent ${DIR} && rm -rf ${2}

  chmod 644 ${1}
  ln -sf ${1} ${2}
}

link ${REPO}/sys/grub /etc/default/grub
update-grub
