

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
  "firmware-linux-nonfree"
  "firmware-misc-nonfree"
  "firmware-iwlwifi"
  "firmware-realtek"

  "network-manager"
  "alsa-utils"

  "sudo"
  "rsync"
  "curl"
  "vim"
  "git"
  "man-db"
  "fuse"

  "xinit"
  "i3"

  "kitty"
  "feh"
  "firefox"
)

for i in ${!PACKAGES[@]}; do
  apt install ${PACKAGES[$i]} -y
done

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
