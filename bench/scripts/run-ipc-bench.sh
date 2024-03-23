#!/bin/bash

export MUSL_HOME=/usr/local/musl
export PATH=$MUSL_HOME/bin:$PATH
export LD_LIBRARY_PATH=$MUSL_HOME/lib:$LD_LIBRARY_PATH

export VMPL_LOG_LEVEL=info
export VMPL_LOG_SHOW_TIME=true

export VMPL_ENABLED=0
export RUN_IN_VMPL=0
export RUN_IN_USER_MODE=1
export RUN_IN_VMPL_PROCESS=1

# Test IPC performance
pushd ipc-bench/build || exit

message_size=1000
roundtrip_count=1000
separator="========================================"

echo $separator Testing PIPE performance
./pipe_lat $message_size $roundtrip_count
./pipe_thr $message_size $roundtrip_count

echo $separator Testing TCP performance
./tcp_lat $message_size $roundtrip_count
./tcp_thr $message_size $roundtrip_count

echo $separator Testing UDP performance
./udp_lat $message_size $roundtrip_count

echo $separator Testing UNIX performance
./unix_lat $message_size $roundtrip_count
./unix_thr $message_size $roundtrip_count

popd