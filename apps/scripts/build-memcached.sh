#!/bin/bash

# This script builds the memcached server from source.
VERSION=1.6.25

pushd memcached || exit 1

git checkout $VERSION || exit 1

./autogen.sh || exit 1

CC=musl-gcc ./configure --prefix=/usr/local/musl

make -j$(nproc) || exit 1

make install || exit 1