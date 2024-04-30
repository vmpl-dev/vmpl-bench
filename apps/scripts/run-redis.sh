#!/bin/bash

echo "Running redis..."
BENCH_HOME=/home/benshan/vmpl-bench
source $BENCH_HOME/scripts/common.sh
if [ $strace_enabled -eq 1 ]; then
    echo "Running redis with strace..."
    strace -o redis.strace redis-server ./redis/redis.conf
else
    redis-server ./redis/redis.conf
fi