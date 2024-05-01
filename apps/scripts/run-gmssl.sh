#!/bin/bash

run_in_vmpl=$1
program=$2

pushd GmSSL/build
if [ "$run_in_vmpl" == "1" ]; then
    ~/scripts/run-app.sh -d -u -r bin/$program
else
    bin/$program
fi
popd