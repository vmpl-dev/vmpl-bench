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

# Set the run mode for the VMPL

# Don't initialize the VMPL library
export VMPL_ENABLED=0

# Don't automatically run in the VMPL
export RUN_IN_VMPL=0

# Run in the user mode
export RUN_IN_USER_MODE=1

# Run in the VMPL process for child processes
export RUN_IN_VMPL_PROCESS=1

# Don't run in the VMPL thread
export RUN_IN_VMPL_THREAD=0