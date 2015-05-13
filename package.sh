#!/usr/bin/env bash
#
# The MIT License (MIT)
#
# Author: Todd Treece <todd@uniontownlabs.org>
# Copyright (c) 2015 Adafruit Industries
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# these should be changed before packaging
GCC_VERSION="4.8.1-arduino5"
AVRDUDE_VERSION="6.0.1-arduino5"
PACKAGE_VERSION="1.2.0"
BOARD_DOWNLOAD_URL="https:\/\/adafruit.github.io\/arduino-board-index\/boards"

# get package script directory
REPO_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# clean build dir
cd $REPO_DIR
rm -r build
mkdir build
cp templates/package.json build/package.json

function archive() {

  # args: archive_name source_path sha_return size_return

  local  __sha=$3
  local  __size=$4

  echo "building $1.tar.bz2..."
  cd $REPO_DIR
  cp -a $2 build/$1
  cd build
  tar -jcf $1.tar.bz2 $1
  rm -r $1

  local sha=$(openssl dgst -sha256 $1.tar.bz2 | awk '{print $2}')
  local size=$(ls -l | grep $1 | awk '{print $5}')

  eval $__sha="'$sha'"
  eval $__size="'$size'"

}

cd $REPO_DIR

#update platform version
sed -i .bak -e "s/^version=.*/version=$PACKAGE_VERSION/" hardware/adafruit/avr/platform.txt
rm hardware/adafruit/avr/platform.txt.bak

# create archives and get sha & size
archive "adafruit-$PACKAGE_VERSION" hardware/adafruit/avr PACKAGESHA PACKAGESIZE

cd $REPO_DIR

# fill in board json template
sed -i .bak -e "s/PACKAGEVERSION/$PACKAGE_VERSION/" \
            -e "s/AVRDUDEVERSION/$AVRDUDE_VERSION/" \
            -e "s/GCCVERSION/$GCC_VERSION/" \
            -e "s/DOWNLOADURL/$BOARD_DOWNLOAD_URL/" \
            -e "s/PACKAGESHA/$PACKAGESHA/" \
            -e "s/PACKAGESIZE/$PACKAGESIZE/" build/package.json

rm build/package.json.bak
