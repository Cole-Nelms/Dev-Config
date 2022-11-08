

#----------------------------------------------------------------------
#
#  This script upgrades debian to unstable,
#  installs packages.
#
#  Just run with no arguments. Make sure
#  to run as root or with sudo, since this is
#  a system wide configuration.
#
#----------------------------------------------------------------------


#!/bin/bash

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

  "xinit"
  "i3"

  "kitty"
  "feh"
  "firefox"
)

for i in ${!PACKAGES[@]}; do
  apt install ${PACKAGES[$i]} -y
done
