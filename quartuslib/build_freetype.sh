#!/bin/bash

# Download FreeType 2.4.12
cd /tmp
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.bz2
tar -xf freetype-2.4.12.tar.bz2
cd freetype-2.4.12

# Build
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make

# Install
cp objs/.libs/* /lib32/