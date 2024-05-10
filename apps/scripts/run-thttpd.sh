#!/bin/bash

echo "Running thttpd..."

source $BENCH_HOME/scripts/common.sh
if [ $strace_enabled -eq 1 ]; then
    echo "Running lighttpd with strace..."
    strace -o thttps.strace thttpd -p 8003 -D -C thttpd-2.29/thttpd_config
else
    thttpd -p 8004 -D -C thttpd-2.29/thttpd_config
fi