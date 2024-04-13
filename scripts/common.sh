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
hotcalls_config_file=""
strace_enabled=0
extra_args=""
# parse arguments
while (( "$#" )); do
    case "$1" in
        --vmpl|-v)
            vmpl_user_mode=1
            shift 1
            ;;
        --hotcalls|-h)
            hotcalls_config_file=$2
            shift 2
            ;;
        --strace|-t)
            strace_enabled=1
            shift 1
            ;;
        --extra_args|-e)
            shift
            extra_args=$@
            break
            ;;
        *)
            echo "Usage: $0 [--vmpl] [--hotcalls <config_file>] [--strace] [--extra_args <args>]"
            exit 1
            ;;
    esac
done

echo "Running with extra arguments: $extra_args"

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

if [ ! -z $hotcalls_config_file ]; then
    export HOTCALLS_CONFIG_FILE=$hotcalls_config_file
    echo "Running in hotcalls mode..."
fi