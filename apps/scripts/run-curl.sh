#!/bin/bash

echo "Running curl benchmark..."

source $BENCH_HOME/scripts/common.sh
if [ $strace_enabled -eq 1 ]; then
    echo "Running curl with strace..."
    strace -o curl.strace curl http://httpforever.com/
else
    curl http://httpforever.com/
fi