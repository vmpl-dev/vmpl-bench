# Applications

## musl

### Rsync /usr/local/musl to VM

```bash
rsync -avzP /usr/local/musl/ amd-guest:/usr/local/musl/
```

## lighttpd

```bash
./scripts/build-lighttpd.sh
```

### Build pcre2-10.43

```bash
tar -xvf pcre2-10.43.tar.gz
cd ~/pcre2-10.43
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

### Build lighttpd-1.4.74

```bash
wget https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.74.tar.xz
tar -xvf lighttpd-1.4.74.tar.xz
cd lighttpd-1.4.74
CC=musl-gcc ./configure --prefix=/usr/local/musl
make install -j128
```

```bash
# ApacheBench Test
ulimit -n 10000
ab -n 10000 -c 1300 http://localhost:18888
```

## proftpd

```bash
./scripts/build-proftpd.sh
```

## redis

```bash
./scripts/build-redis.sh
```

### Redis-6.2.5 Test

### Redis-6.2.5 on VM

### 启动redis server on VM (vmpl disabled)

```bash
# 启动redis
redis-server ~/redis.conf
# 连接redis
redis-cli
```

### 启动redis server on VM (vmpl enabled)

```bash
sudo ./run-app.sh --dunify ./dunify.so --run /usr/local/muslbin/redis-server ./redis.conf
```

### 测试redis server

```bash
# 测试redis server
redis-benchmark -h
```

## memcached

### Memcached-1.6.9 Test

启动memcached server on VM

```bash
# 安装libmemcached-tools
sudo apt install libmemcached-tools
# 启动memcached 单线程 64MB内存 11211端口
memcached -u root -m 64 -p 11211 -t 1
memcached-tool
```

测试memcached server

```bash
# 测试memcached server
memcached-benchmark -h
```

## nginx

### nginx benchmark

```bash
# 启动nginx
sudo ./run-app.sh --dunify ./dunify.so --run /usr/local/muslbin/nginx -c /usr/local/musl/etc/nginx/nginx.conf
# 测试nginx
ab -n 100000 -c 1000 http://localhost:8080/
```
