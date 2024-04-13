#!/bin/bash

echo "Running lighttpd..."

pushd etc || exit
cp lighttpd.conf.template lighttpd.conf

sed -i "s/usrname/$(id -un)/g" lighttpd.conf
sed -i "s/grpname/$(id -gn)/g" lighttpd.conf

head -n 7 lighttpd.conf
echo "..."
popd

source $BENCH_HOME/scripts/common.sh
if [ $strace_enabled -eq 1 ]; then
    echo "Running lighttpd with strace..."
    strace -o lighttpd.strace ./lighttpd/src/lighttpd -f etc/lighttpd.conf -m ./lighttpd/src/.libs -D
else
    ./lighttpd/src/lighttpd -f etc/lighttpd.conf -m ./lighttpd/src/.libs -D
fi