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
test -f v1.7.17.tar.gz || wget https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.17.tar.gz
test -d cJSON-1.7.17 || tar -xvf v1.7.17.tar.gz
cd cJSON-1.7.17
make CC=musl-gcc all
make CC=musl-gcc PREFIX=/usr/local/musl install
```

### libxml2-2.12.5

```bash
test -f libxml2-2.12.5.tar.xz || wget https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.5.tar.xz
test -d libxml2-2.12.5 || tar -xvf libxml2-2.12.5.tar.xz
cd libxml2-2.12.5/
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

### libutf

```bash
git clone git@github.com:cls/libutf.git
cd libutf
make all CC=musl-gcc PREFIX=/usr/local/musl install
```

### jemalloc

```bash
wget https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2
tar -xvf jemalloc-5.3.0.tar.bz2
cd jemalloc-5.3.0
CC=musl-gcc ./configure --prefix=/usr/local/musl --disable-cxx
make install -j128
```

### libpng

```bash
git clone git@github.com:pnggroup/libpng.git
cd libpng
git checkout v1.6.43
CC=musl-gcc ./configure --prefix=/usr/local/musl --enable-intel-sse --enable-shared
make install -j128
```

### libexpat

```bash
git clone git@github.com:libexpat/libexpat.git
cd libexpat
git checkout 2.6.2
cd expat
./buildconf.sh
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

### libtiff

```bash
test -f tiff-4.6.0.tar.xz || wget http://download.osgeo.org/libtiff/tiff-4.6.0.tar.xz
test -d tiff-4.6.0 || tar -xvf tiff-4.6.0.tar.xz
cd tiff-4.6.0
./autogen.sh
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

### bzip2

```bash
test -f bzip2-latest.tar.gz || wget https://sourceware.org/pub/bzip2/bzip2-latest.tar.gz
test -d bzip2-1.0.8 || tar -xvf bzip2-latest.tar.gz
cd bzip2-1.0.8
make CC=musl-gcc PREFIX=/usr/local/musl install -j128
```

### perl-5.38.2

```bash
test -f perl-5.38.2.tar.gz || wget https://www.cpan.org/src/5.0/perl-5.38.2.tar.gz
test -d perl-5.38.2 || tar -xvf perl-5.38.2.tar.gz
cd perl-5.38.2
CC=musl-gcc ./Configure -des -Dprefix=/usr/local/musl
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
