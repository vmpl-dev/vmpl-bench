#!/bin/bash -v

# This script builds the Apache HTTP server from source.

# Define the version of Apache HTTP server to build.
HTTPD_VERSION=2.4.58

pushd httpd || exit 1
git checkout $HTTPD_VERSION || exit 1
./buildconf || exit 1