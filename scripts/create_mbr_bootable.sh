
# This script is for making an
# image file (.iso) bootable
# through a media drive. It
# may require root privledges to
# run. The first argument
# accepts a path to a image
# file. The second Argument
# accepts a path to a media
# drive, (example: '/dev/sda').
# It will delete all drive partitions
# and then make an empty dos
# partition table. Then it
# will format the drive
# to fat32. Finally it will install
# the iso file to the drive.

# tweaks and changes may be
# needed for other systems
# and/or media drives.
# Good luck!!

#!/bin/sh

# Make sure media is unmounted
umount $2*

# Setup partition table
fdisk $2 << EOF
o
w
EOF

# Give media fat32 file system
mkfs.vfat -I -F 32 $2

# Install image file to partition
dd if=$1 of=$2 status=progress

