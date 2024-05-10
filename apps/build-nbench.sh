#!/bin/bash

# This script will build the nbench benchmarking tool
# https://www.math.utah.edu/~mayer/linux/bmark.html

# Install the required packages
sudo apt-get install -y build-essential

# Download the tarball
wget http://www.math.utah.edu/~mayer/linux/nbench-byte-2.2.3.tar.gz

# Extract the tarball
tar xzf nbench-byte-2.2.3.tar.gz

# Change to the source directory
cd nbench-byte-2.2.3

# Compile the program
make -j$(nproc)