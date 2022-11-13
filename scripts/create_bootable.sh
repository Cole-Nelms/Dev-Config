
# This script is for making an
# image file bootable
# through a media drive. It
# may require root privledges to
# run. The first argument
# accepts a path to an image
# file. The second Argument
# accepts a path to a media
# drive, (example: '/dev/sda').
# It will overwrite all drive data
# with a new bootable operating
# system by writing the
# image file to the drive.

#!/bin/sh

# Make sure media is unmounted
umount $2*

# Install image file to drive
dd if=$1 of=$2 status=progress
