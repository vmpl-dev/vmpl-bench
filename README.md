# Benchmarks for the VMPL project

## Benchmarking tools

```bash
# Install the benchmarking tools
export BENCH_HOME=~/vmpl-process/vmpl-bench
```

## Real-world applications

### libuv-v1.48.0

```bash
wget https://dist.libuv.org/dist/v1.48.0/libuv-v1.48.0.tar.gz
tar -xvf libuv-v1.48.0.tar.gz
cd libuv-v1.48.0
./autogen.sh
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

### liburing-2.5

```bash
wget https://git.kernel.dk/cgit/liburing/snapshot/liburing-2.5.tar.gz
tar -xvf liburing-2.5.tar.gz
cd liburing-2.5
CC=musl-gcc ./configure --prefix=/usr/local/musl --cc=musl-gcc --cxx=musl-gcc
make install -j128
```

### libaio-0.3.113

```bash
wget https://pagure.io/libaio/archive/libaio-0.3.113/libaio-libaio-0.3.113.tar.gz
tar -xvf libaio-libaio-0.3.113.tar.gz
cd libaio-libaio-0.3.113
make CC=musl-gcc PREFIX=/usr/local/musl install
```

### cJSON-1.7.17

```bash
wget https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.17.tar.gz
tar -xvf v1.7.17.tar.gz
cd cJSON-1.7.17
make CC=musl-gcc all
make CC=musl-gcc PREFIX=/usr/local/musl install
```

### libxml2-2.12.5

```bash
wget https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.5.tar.xz
tar -xvf libxml2-2.12.5.tar.xz
cd libxml2-2.12.5/
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

## Docker Test

### Build docker image

```bash
# 进入docker目录
cd ~/vmpl-process/docker
# 构建docker镜像
sudo docker build -t vmpl-process .
```

```bash
docker run -it -v$(pwd):/root/app --workdir=/root/app andrewd/musl-clang /bin/bash
```