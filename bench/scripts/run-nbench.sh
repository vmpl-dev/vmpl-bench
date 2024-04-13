#!/bin/bash

source $BENCH_HOME/scripts/common.sh

echo "Running nbench benchmark..."

# Test nbench performance
pushd nbench || exit
cmd_file="NBENCH.CMD"
echo "Running with extra arguments: $extra_args"
echo "CUSTOMRUN=T" > $cmd_file
# echo "ALLSTATS=T" >> $cmd_file
echo "OUTFILE=NBENCH-$extra_args.out" >> $cmd_file
echo "$extra_args=T" >> $cmd_file

if [ $strace_enabled -eq 1 ]; then
    echo "Running nbench with strace..."
    strace -o nbench.strace ./nbench -c$cmd_file
else
    ./nbench -c$cmd_file
fi

popd || exit