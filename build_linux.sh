#!/bin/bash
#
# Shell script to take a normal Arduino Linux build and create a new version
# that has Adafruit's board built in to it.
#
# Takes 2 command line parameters, like:
# ./build_linux.sh arduino-1.6.4-linux32.tar.xz adafruit-arduino-1.6.4-linux32.tar.xz
#
# Where the first parameter is the input file and the second parameter is the new
# file to create.  The script will decompress the input, add Adafruit's boards,
# and compress the file back into a .tar.xz file with the output name.
#
set -e

# Location to use as a staging are for decompressing files.
STAGING=/tmp/adafruit_boards
# Expected extension of the input and output files.
EXTENSION=.tar.xz

# Check that there are two command line parameters.
if [[ "$#" -ne 2 ]]; then
    echo "Error! Expected an input and output file as parameters.  Usage:"
    echo "./build_linux.sh <input Arduino build> <output modified Arduino build>"
    exit -1
fi

echo "Building Arduino download for Linux using:"
echo "Input:    $1"
echo "Output:   $2"

# Check that input has expected extension.
if [[ ! $1 == *$EXTENSION ]]; then
    echo "Error! Expected input to be of type $EXTENSION"
    exit -1
fi

# Delete working area in /tmp/adafruit_boards if it exists.
if [[ -d "$STAGING" ]]; then
    echo "Deleting temporary staging area $STAGING..."
    rm -rf --preserve-root "$STAGING"
fi

# Create working area in /tmp/adafruit_boards
mkdir -p "$STAGING"

# Decompress the input to the staging area.
echo "Decompressing input..."
tar xfC "$1" "$STAGING"

# Check only one subfolder exists and get is values.
if [[ $(find "$STAGING" -maxdepth 1 -mindepth 1 -type d | wc -l) -ne 1 ]]; then
    echo "Error! Expected one subdirectory in staging area!"
    exit -1
fi
SUBDIR=$(find "$STAGING" -maxdepth 1 -mindepth 1 -type d -printf %f)

# Check a hardware subfolder exists.
if [[ ! -d "$STAGING/$SUBDIR/hardware" ]]; then
    echo "Error! Expected hardware subfolder but could not find it!"
    exit -1
fi

# Copy Adafruit boards into hardware subfolder.
echo "Copying Adafruit boards into staging area..."
cp -rf hardware "$STAGING/$SUBDIR"

# Create output archive by compressing staging area.
echo "Compressing modified IDE..."
tar cfJC "$2" "$STAGING" "$SUBDIR"

echo "Done!"
