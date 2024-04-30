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
thread_enabled=0
extra_args=""
silent=0
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
        --thread|-T)
            thread_enabled=1
            shift 1
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
        --silent|-s)
            silent=1
            shift 1
            ;;
        *)
            echo "Usage: $0 [--vmpl] [--hotcalls <config_file>] [--strace] [--thread] [--extra_args <args>] [--silent]"
            exit 1
            ;;
    esac
done

echo "Running with extra arguments: $extra_args"

if [ $vmpl_user_mode -eq 1 ]; then
    export VMPL_ENABLED=1
    export RUN_IN_VMPL=1
    export RUN_IN_USER_MODE=1
    export RUN_IN_VMPL_THREAD=1
    export LD_PRELOAD=libdunify.so
    echo "Running in VMPL user mode..."
else
    echo "Running in native mode..."
fi
if [ $thread_enabled -eq 1 ]; then
    export VMPL_ENABLED=1
    export RUN_IN_USER_MODE=1
    export RUN_IN_VMPL_THREAD=1
    export LD_PRELOAD=libdunify.so
    echo "Running in vmpl-thread mode..."
fi

if [ -n "$hotcalls_config_file" ]; then
    export HOTCALLS_CONFIG_FILE=$hotcalls_config_file
    echo "Running in hotcalls mode..."
fi

if [ $strace_enabled -eq 1 ]; then
    echo "Running with strace..."
fi

if [ $silent -eq 1 ]; then
    echo "Running in silent mode..."
    export VMPL_LOG_LEVEL=success
fi