#!/bin/bash
# Description: Common functions and variables for the VMPL benchmarking.

# 1.1.1  Set the Environment Variables
# Set the environment variables for the VMPL benchmarking

# Set the path to the musl library
export MUSL_HOME=/usr/local/musl
export PATH=$MUSL_HOME/bin:$PATH
export LD_LIBRARY_PATH=$MUSL_HOME/lib:$LD_LIBRARY_PATH

# Set the log level and show time for the VMPL
export VMPL_LOG_LEVEL=info
export VMPL_LOG_SHOW_TIME=true

vmpl_user_mode=0
hotcalls_mode=0
# parse arguments
while getopts "v:h" opt; do
    case ${opt} in
        v )
        vmpl_user_mode=$OPTARG
        ;;
        h )
        hotcalls_mode=1
        ;;
        \? )
        echo "Usage: cmd [-v vmpl_user_mode] [-h hotcalls_mode]"
        ;;
    esac
done

if [ $vmpl_user_mode -eq 1 ]; then
    export VMPL_ENABLED=1
    export RUN_IN_VMPL=1
    export RUN_IN_USER_MODE=1
    export RUN_IN_VMPL_PROCESS=0
    export RUN_IN_VMPL_THREAD=1
    export LD_PRELOAD=libdunify.so
    echo "Running in VMPL user mode..."
else
    export VMPL_ENABLED=0
    export RUN_IN_VMPL=0
    export RUN_IN_USER_MODE=0
    echo "Running in native mode..."
fi

if [ $hotcalls_mode -eq 1 ]; then
    export HOTCALLS_ENABLED=1
fi