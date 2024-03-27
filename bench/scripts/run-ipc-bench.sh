#!/bin/bash

source $BENCH_HOME/scripts/common.sh

echo "Running IPC benchmark..."

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