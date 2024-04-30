#!/bin/bash

source $BENCH_HOME/scripts/common.sh

nbench_dir=nbench-byte-2.2.3
echo "Running $nbench_dir benchmark..."

# Test nbench performance
pushd $nbench_dir || exit
cmd_file="NBENCH.CMD"
echo "Running with extra arguments: $extra_args"
echo "ALLSTATS=T" > $cmd_file
echo "CUSTOMRUN=T" >> $cmd_file
echo "OUTFILE=NBENCH-$extra_args.out" >> $cmd_file
echo "$extra_args=T" >> $cmd_file

if [ $strace_enabled -eq 1 ]; then
    echo "Running $nbench_dir with strace..."
    strace -o nbench.strace ./nbench -c$cmd_file
else
    ./nbench -c$cmd_file
fi

popd || exit