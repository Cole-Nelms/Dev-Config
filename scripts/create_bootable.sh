

#----------------------------------------------------------------------
#
# This script is for making an
# image file bootable
# through a media drive.
#
# The first argument
# accepts a path to an image
# file. The second Argument
# accepts a path to a media
# drive, (example: '/dev/sda').
#
# It will overwrite all drive data
# with a new bootable operating
# system by writing the
# image file to the drive.
#
#----------------------------------------------------------------------


#!/bin/sh

umount $2* && dd if=$1 of=$2 status=progress
