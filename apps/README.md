# Applications

## musl

### Rsync /usr/local/musl to VM

```bash
rsync -avzP /usr/local/musl/ amd-guest:/usr/local/musl/
```

## curl

```bash
$ autoreconf -fi
$ ./configure --prefix=/usr/local/musl --without-ssl
configure: Configured to build curl/libcurl:

  Host setup:       x86_64-pc-linux-musl
  Install prefix:   /usr/local/musl
  Compiler:         musl-gcc
   CFLAGS:          -Werror-implicit-function-declaration -O2 -Wno-system-headers
   CPPFLAGS:        
   LDFLAGS:         
   LIBS:            -lz

  curl version:     8.8.0-DEV
  SSL:              no      (--with-{openssl,gnutls,mbedtls,wolfssl,schannel,secure-transport,amissl,bearssl,rustls} )
  SSH:              no      (--with-{libssh,libssh2})
  zlib:             enabled
  brotli:           no      (--with-brotli)
  zstd:             no      (--with-zstd)
  GSS-API:          no      (--with-gssapi)
  GSASL:            no      (libgsasl not found)
  TLS-SRP:          no      (--enable-tls-srp)
  resolver:         POSIX threaded
  IPv6:             enabled
  Unix sockets:     enabled
  IDN:              no      (--with-{libidn2,winidn})
  Build docs:       enabled (--disable-docs)
  Build libcurl:    Shared=yes, Static=yes
  Built-in manual:  enabled
  --libcurl option: enabled (--disable-libcurl-option)
  Verbose errors:   enabled (--disable-verbose)
  Code coverage:    disabled
  SSPI:             no      (--enable-sspi)
  ca cert bundle:   no
  ca cert path:     
  ca fallback:      
  LDAP:             no      (--enable-ldap / --with-ldap-lib / --with-lber-lib)
  LDAPS:            no      (--enable-ldaps)
  RTSP:             enabled
  RTMP:             no      (--with-librtmp)
  PSL:              no      (--with-libpsl)
  Alt-svc:          enabled (--disable-alt-svc)
  Headers API:      enabled (--disable-headers-api)
  HSTS:             no      (--enable-hsts)
  HTTP1:            enabled (internal)
  HTTP2:            no      (--with-nghttp2)
  HTTP3:            no      (--with-ngtcp2 --with-nghttp3, --with-quiche, --with-openssl-quic, --with-msh3)
  ECH:              no      (--enable-ech)
  WebSockets:       no      (--enable-websockets)
  Protocols:        DICT FILE FTP GOPHER HTTP IMAP IPFS IPNS MQTT POP3 RTSP SMTP TELNET TFTP
  Features:         AsynchDNS IPv6 Largefile UnixSockets alt-svc libz threadsafe
make install -j128
```

## apache httpd

```bash
./scripts/build-httpd.sh
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
# 2401:C 22 Apr 2024 00:40:11.287 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
sysctl vm.overcommit_memory=1
sudo ./run-app.sh --dunify ./dunify.so --run /usr/local/musl/bin/redis-server ./redis.conf
```

### 测试redis server

```bash
# 测试redis server
redis-benchmark -h
# 测试redis server
server: redis-server ./bin/redis.conf &
bench : redis-benchmark -n 1000 -c 1
client: redis-cli
```

## memcached

> 编译出问题了，因为没有完整的sysroot，所以编译的时候会报错，需要完整的sysroot

```bash
./scripts/build-memcached.sh
```

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
sudo ./run-app.sh --dunify ./dunify.so --run /usr/local/musl/bin/nginx -c /usr/local/musl/etc/nginx/nginx.conf
# 测试nginx
ab -n 100000 -c 1000 http://localhost:8080/
```

## mbedtls

### public-Super-Server

```bash
benshan@public-Super-Server:~/vmpl-process$ strace -o benchmark.strace benchmark

  MD5                      :     645297 KiB/s,          4 cycles/byte
  RIPEMD160                :     450892 KiB/s,          6 cycles/byte
  SHA-1                    :     664340 KiB/s,          4 cycles/byte
  SHA-256                  :     295628 KiB/s,          9 cycles/byte
  SHA-512                  :     324527 KiB/s,          8 cycles/byte
  SHA3-224                 :     155941 KiB/s,         17 cycles/byte
  SHA3-256                 :     155132 KiB/s,         17 cycles/byte
  SHA3-384                 :     125905 KiB/s,         21 cycles/byte
  SHA3-512                 :      86503 KiB/s,         32 cycles/byte
  3DES                     :      34131 KiB/s,         79 cycles/byte
  DES                      :      85036 KiB/s,         32 cycles/byte
  3DES-CMAC                :      32984 KiB/s,         83 cycles/byte
  AES-CBC-128              :     827558 KiB/s,          3 cycles/byte
  AES-CBC-192              :     742934 KiB/s,          3 cycles/byte
  AES-CBC-256              :     673950 KiB/s,          4 cycles/byte
  AES-CFB128-128           :     421034 KiB/s,          6 cycles/byte
  AES-CFB128-192           :     395096 KiB/s,          6 cycles/byte
  AES-CFB128-256           :     372627 KiB/s,          7 cycles/byte
  AES-CFB8-128             :      38616 KiB/s,         70 cycles/byte
  AES-CFB8-192             :      35409 KiB/s,         77 cycles/byte
  AES-CFB8-256             :      32866 KiB/s,         83 cycles/byte
  AES-CTR-128              :     936066 KiB/s,          2 cycles/byte
  AES-CTR-192              :     829003 KiB/s,          3 cycles/byte
  AES-CTR-256              :     743677 KiB/s,          3 cycles/byte
  AES-XTS-128              :     802617 KiB/s,          3 cycles/byte
  AES-XTS-256              :     656629 KiB/s,          4 cycles/byte
  AES-GCM-128              :     337640 KiB/s,          8 cycles/byte
  AES-GCM-192              :     323424 KiB/s,          8 cycles/byte
  AES-GCM-256              :     309036 KiB/s,          8 cycles/byte
  AES-CCM-128              :     455274 KiB/s,          6 cycles/byte
  AES-CCM-192              :     413682 KiB/s,          6 cycles/byte
  AES-CCM-256              :     379621 KiB/s,          7 cycles/byte
  ChaCha20-Poly1305        :     362846 KiB/s,          7 cycles/byte
  AES-CMAC-128             :     651476 KiB/s,          4 cycles/byte
  AES-CMAC-192             :     596725 KiB/s,          4 cycles/byte
  AES-CMAC-256             :     548992 KiB/s,          4 cycles/byte
  AES-CMAC-PRF-128         :     648760 KiB/s,          4 cycles/byte
  ARIA-CBC-128             :      99631 KiB/s,         27 cycles/byte
  ARIA-CBC-192             :      87790 KiB/s,         31 cycles/byte
  ARIA-CBC-256             :      78061 KiB/s,         35 cycles/byte
  CAMELLIA-CBC-128         :     111701 KiB/s,         24 cycles/byte
  CAMELLIA-CBC-192         :      84819 KiB/s,         32 cycles/byte
  CAMELLIA-CBC-256         :      84165 KiB/s,         32 cycles/byte
  ChaCha20                 :     506228 KiB/s,          5 cycles/byte
  Poly1305                 :    1579050 KiB/s,          1 cycles/byte
  CTR_DRBG (NOPR)          :     608965 KiB/s,          4 cycles/byte
  CTR_DRBG (PR)            :     423777 KiB/s,          6 cycles/byte
  HMAC_DRBG SHA-1 (NOPR)   :      46545 KiB/s,         58 cycles/byte
  HMAC_DRBG SHA-1 (PR)     :      42989 KiB/s,         63 cycles/byte
  HMAC_DRBG SHA-256 (NOPR) :      30126 KiB/s,         90 cycles/byte
  HMAC_DRBG SHA-256 (PR)   :      30185 KiB/s,         91 cycles/byte
  RSA-2048                 :    4037  public/s
  RSA-2048                 :     428 private/s
  RSA-3072                 :    1744  public/s
  RSA-3072                 :     156 private/s
  RSA-4096                 :     954  public/s
  RSA-4096                 :      74 private/s
  DHE-2048                 :      96 handshake/s
  DH-2048                  :     188 handshake/s
  DHE-3072                 :      28 handshake/s
  DH-3072                  :      54 handshake/s
  ECDSA-secp521r1          :    1411 sign/s
  ECDSA-brainpoolP512r1    :     212 sign/s
  ECDSA-secp384r1          :    2020 sign/s
  ECDSA-brainpoolP384r1    :     441 sign/s
  ECDSA-secp256r1          :    2968 sign/s
  ECDSA-secp256k1          :    2238 sign/s
  ECDSA-brainpoolP256r1    :     696 sign/s
  ECDSA-secp224r1          :    4016 sign/s
  ECDSA-secp224k1          :    2356 sign/s
  ECDSA-secp192r1          :    5214 sign/s
  ECDSA-secp192k1          :    3149 sign/s
  ECDSA-secp521r1          :     365 verify/s
  ECDSA-brainpoolP512r1    :      44 verify/s
  ECDSA-secp384r1          :     514 verify/s
  ECDSA-brainpoolP384r1    :      95 verify/s
  ECDSA-secp256r1          :     830 verify/s
  ECDSA-secp256k1          :     655 verify/s
  ECDSA-brainpoolP256r1    :     178 verify/s
  ECDSA-secp224r1          :    1187 verify/s
  ECDSA-secp224k1          :     702 verify/s
  ECDSA-secp192r1          :    1613 verify/s
  ECDSA-secp192k1          :     904 verify/s
  ECDHE-secp521r1          :     390 ephemeral handshake/s
  ECDHE-brainpoolP512r1    :      35 ephemeral handshake/s
  ECDHE-secp384r1          :     578 ephemeral handshake/s
  ECDHE-brainpoolP384r1    :      89 ephemeral handshake/s
  ECDHE-secp256r1          :     924 ephemeral handshake/s
  ECDHE-secp256k1          :     691 ephemeral handshake/s
  ECDHE-brainpoolP256r1    :     166 ephemeral handshake/s
  ECDHE-secp224r1          :    1298 ephemeral handshake/s
  ECDHE-secp224k1          :     733 ephemeral handshake/s
  ECDHE-secp192r1          :    1630 ephemeral handshake/s
  ECDHE-secp192k1          :     942 ephemeral handshake/s
  ECDHE-x25519             :     683 ephemeral handshake/s
  ECDHE-x448               :     272 ephemeral handshake/s
  ECDH-secp521r1           :     510 static handshake/s
  ECDH-brainpoolP512r1     :      39 static handshake/s
  ECDH-secp384r1           :     769 static handshake/s
  ECDH-brainpoolP384r1     :     124 static handshake/s
  ECDH-secp256r1           :    1261 static handshake/s
  ECDH-secp256k1           :     968 static handshake/s
  ECDH-brainpoolP256r1     :     253 static handshake/s
  ECDH-secp224r1           :    1784 static handshake/s
  ECDH-secp224k1           :    1016 static handshake/s
  ECDH-secp192r1           :    1987 static handshake/s
  ECDH-secp192k1           :    1220 static handshake/s
  ECDH-x25519              :    1255 static handshake/s
  ECDH-x448                :     632 static handshake/s
benshan@public-Super-Server:~$ benchmark

  MD5                      :     646503 KiB/s,          4 cycles/byte
  RIPEMD160                :     450367 KiB/s,          6 cycles/byte
  SHA-1                    :     663774 KiB/s,          4 cycles/byte
  SHA-256                  :     295554 KiB/s,          9 cycles/byte
  SHA-512                  :     325472 KiB/s,          8 cycles/byte
  SHA3-224                 :     153842 KiB/s,         17 cycles/byte
  SHA3-256                 :     153064 KiB/s,         18 cycles/byte
  SHA3-384                 :     123833 KiB/s,         22 cycles/byte
  SHA3-512                 :      85198 KiB/s,         31 cycles/byte
  3DES                     :      34234 KiB/s,         79 cycles/byte
  DES                      :      85125 KiB/s,         32 cycles/byte
  3DES-CMAC                :      32945 KiB/s,         82 cycles/byte
  AES-CBC-128              :     827658 KiB/s,          3 cycles/byte
  AES-CBC-192              :     742943 KiB/s,          3 cycles/byte
  AES-CBC-256              :     671798 KiB/s,          4 cycles/byte
  AES-CFB128-128           :     421362 KiB/s,          6 cycles/byte
  AES-CFB128-192           :     394045 KiB/s,          6 cycles/byte
  AES-CFB128-256           :     370846 KiB/s,          7 cycles/byte
  AES-CFB8-128             :      38616 KiB/s,         70 cycles/byte
  AES-CFB8-192             :      35405 KiB/s,         77 cycles/byte
  AES-CFB8-256             :      32869 KiB/s,         83 cycles/byte
  AES-CTR-128              :     936101 KiB/s,          2 cycles/byte
  AES-CTR-192              :     829272 KiB/s,          3 cycles/byte
  AES-CTR-256              :     743932 KiB/s,          3 cycles/byte
  AES-XTS-128              :     802388 KiB/s,          3 cycles/byte
  AES-XTS-256              :     656835 KiB/s,          4 cycles/byte
  AES-GCM-128              :     338050 KiB/s,          8 cycles/byte
  AES-GCM-192              :     323609 KiB/s,          8 cycles/byte
  AES-GCM-256              :     309182 KiB/s,          8 cycles/byte
  AES-CCM-128              :     476448 KiB/s,          5 cycles/byte
  AES-CCM-192              :     434983 KiB/s,          6 cycles/byte
  AES-CCM-256              :     396630 KiB/s,          6 cycles/byte
  ChaCha20-Poly1305        :     362122 KiB/s,          7 cycles/byte
  AES-CMAC-128             :     621528 KiB/s,          4 cycles/byte
  AES-CMAC-192             :     569832 KiB/s,          4 cycles/byte
  AES-CMAC-256             :     526990 KiB/s,          5 cycles/byte
  AES-CMAC-PRF-128         :     618635 KiB/s,          4 cycles/byte
  ARIA-CBC-128             :      99723 KiB/s,         27 cycles/byte
  ARIA-CBC-192             :      87058 KiB/s,         31 cycles/byte
  ARIA-CBC-256             :      77337 KiB/s,         35 cycles/byte
  CAMELLIA-CBC-128         :     110241 KiB/s,         25 cycles/byte
  CAMELLIA-CBC-192         :      83971 KiB/s,         32 cycles/byte
  CAMELLIA-CBC-256         :      83759 KiB/s,         32 cycles/byte
  ChaCha20                 :     514188 KiB/s,          5 cycles/byte
  Poly1305                 :    1577163 KiB/s,          1 cycles/byte
  CTR_DRBG (NOPR)          :     607859 KiB/s,          4 cycles/byte
  CTR_DRBG (PR)            :     423729 KiB/s,          6 cycles/byte
  HMAC_DRBG SHA-1 (NOPR)   :      46220 KiB/s,         58 cycles/byte
  HMAC_DRBG SHA-1 (PR)     :      43148 KiB/s,         62 cycles/byte
  HMAC_DRBG SHA-256 (NOPR) :      29330 KiB/s,         92 cycles/byte
  HMAC_DRBG SHA-256 (PR)   :      29348 KiB/s,         94 cycles/byte
  RSA-2048                 :    4058  public/s
  RSA-2048                 :     446 private/s
  RSA-3072                 :    1743  public/s
  RSA-3072                 :     164 private/s
  RSA-4096                 :     957  public/s
  RSA-4096                 :      76 private/s
  DHE-2048                 :      96 handshake/s
  DH-2048                  :     189 handshake/s
  DHE-3072                 :      28 handshake/s
  DH-3072                  :      54 handshake/s
  ECDSA-secp521r1          :    1409 sign/s
  ECDSA-brainpoolP512r1    :     207 sign/s
  ECDSA-secp384r1          :    2072 sign/s
  ECDSA-brainpoolP384r1    :     437 sign/s
  ECDSA-secp256r1          :    2957 sign/s
  ECDSA-secp256k1          :    2356 sign/s
  ECDSA-brainpoolP256r1    :     708 sign/s
  ECDSA-secp224r1          :    4084 sign/s
  ECDSA-secp224k1          :    2558 sign/s
  ECDSA-secp192r1          :    5431 sign/s
  ECDSA-secp192k1          :    3340 sign/s
  ECDSA-secp521r1          :     388 verify/s
  ECDSA-brainpoolP512r1    :      46 verify/s
  ECDSA-secp384r1          :     564 verify/s
  ECDSA-brainpoolP384r1    :      98 verify/s
  ECDSA-secp256r1          :     858 verify/s
  ECDSA-secp256k1          :     670 verify/s
  ECDSA-brainpoolP256r1    :     182 verify/s
  ECDSA-secp224r1          :    1196 verify/s
  ECDSA-secp224k1          :     725 verify/s
  ECDSA-secp192r1          :    1671 verify/s
  ECDSA-secp192k1          :     932 verify/s
  ECDHE-secp521r1          :     416 ephemeral handshake/s
  ECDHE-brainpoolP512r1    :      47 ephemeral handshake/s
  ECDHE-secp384r1          :     600 ephemeral handshake/s
  ECDHE-brainpoolP384r1    :     103 ephemeral handshake/s
  ECDHE-secp256r1          :     921 ephemeral handshake/s
  ECDHE-secp256k1          :     703 ephemeral handshake/s
  ECDHE-brainpoolP256r1    :     190 ephemeral handshake/s
  ECDHE-secp224r1          :    1321 ephemeral handshake/s
  ECDHE-secp224k1          :     752 ephemeral handshake/s
  ECDHE-secp192r1          :    1826 ephemeral handshake/s
  ECDHE-secp192k1          :    1014 ephemeral handshake/s
  ECDHE-x25519             :     681 ephemeral handshake/s
  ECDHE-x448               :     282 ephemeral handshake/s
  ECDH-secp521r1           :     551 static handshake/s
  ECDH-brainpoolP512r1     :      60 static handshake/s
  ECDH-secp384r1           :     805 static handshake/s
  ECDH-brainpoolP384r1     :     130 static handshake/s
  ECDH-secp256r1           :    1252 static handshake/s
  ECDH-secp256k1           :     979 static handshake/s
  ECDH-brainpoolP256r1     :     257 static handshake/s
  ECDH-secp224r1           :    1771 static handshake/s
  ECDH-secp224k1           :    1044 static handshake/s
  ECDH-secp192r1           :    2469 static handshake/s
  ECDH-secp192k1           :    1333 static handshake/s
  ECDH-x25519              :    1236 static handshake/s
  ECDH-x448                :     623 static handshake/s

benshan@public-Super-Server:~$
```

### sev-snp-guest

```bash
benshan@sev-snp-guest:~$ benchmark

  MD5                      :     599049 KiB/s,          4 cycles/byte
  RIPEMD160                :     434021 KiB/s,          6 cycles/byte
  SHA-1                    :     637474 KiB/s,          4 cycles/byte
  SHA-256                  :     283167 KiB/s,          9 cycles/byte
  SHA-512                  :     314650 KiB/s,          8 cycles/byte
  SHA3-224                 :     149702 KiB/s,         17 cycles/byte
  SHA3-256                 :     149284 KiB/s,         17 cycles/byte
  SHA3-384                 :     121146 KiB/s,         21 cycles/byte
  SHA3-512                 :      83242 KiB/s,         31 cycles/byte
  3DES                     :      32819 KiB/s,         80 cycles/byte
  DES                      :      82256 KiB/s,         32 cycles/byte
  3DES-CMAC                :      31487 KiB/s,         83 cycles/byte
  AES-CBC-128              :     792984 KiB/s,          3 cycles/byte
  AES-CBC-192              :     715076 KiB/s,         11 cycles/byte
  AES-CBC-256              :     643996 KiB/s,          4 cycles/byte
  AES-CFB128-128           :     397836 KiB/s,          6 cycles/byte
  AES-CFB128-192           :     381625 KiB/s,          7 cycles/byte
  AES-CFB128-256           :     355577 KiB/s,          7 cycles/byte
  AES-CFB8-128             :      37099 KiB/s,         70 cycles/byte
  AES-CFB8-192             :      34100 KiB/s,         87 cycles/byte
  AES-CFB8-256             :      31829 KiB/s,         83 cycles/byte
  AES-CTR-128              :     893864 KiB/s,          2 cycles/byte
  AES-CTR-192              :     793576 KiB/s,          3 cycles/byte
  AES-CTR-256              :     720664 KiB/s,          3 cycles/byte
  AES-XTS-128              :     771088 KiB/s,          3 cycles/byte
  AES-XTS-256              :     630127 KiB/s,          4 cycles/byte
  AES-GCM-128              :     324964 KiB/s,          8 cycles/byte
  AES-GCM-192              :     309306 KiB/s,          8 cycles/byte
  AES-GCM-256              :     295945 KiB/s,          8 cycles/byte
  AES-CCM-128              :     456302 KiB/s,          5 cycles/byte
  AES-CCM-192              :     416964 KiB/s,          6 cycles/byte
  AES-CCM-256              :     387648 KiB/s,          8 cycles/byte
  ChaCha20-Poly1305        :     346787 KiB/s,          7 cycles/byte
  AES-CMAC-128             :     595420 KiB/s,          4 cycles/byte
  AES-CMAC-192             :     553758 KiB/s,          4 cycles/byte
  AES-CMAC-256             :     509115 KiB/s,          5 cycles/byte
  AES-CMAC-PRF-128         :     595746 KiB/s,          4 cycles/byte
  ARIA-CBC-128             :      98262 KiB/s,         27 cycles/byte
  ARIA-CBC-192             :      85318 KiB/s,         31 cycles/byte
  ARIA-CBC-256             :      75742 KiB/s,         35 cycles/byte
  CAMELLIA-CBC-128         :     109490 KiB/s,         26 cycles/byte
  CAMELLIA-CBC-192         :      82425 KiB/s,         32 cycles/byte
  CAMELLIA-CBC-256         :      82765 KiB/s,         32 cycles/byte
  ChaCha20                 :     500843 KiB/s,          7 cycles/byte
  Poly1305                 :    1539181 KiB/s,          1 cycles/byte
  CTR_DRBG (NOPR)          :     594891 KiB/s,          4 cycles/byte
  CTR_DRBG (PR)            :     415365 KiB/s,          6 cycles/byte
  HMAC_DRBG SHA-1 (NOPR)   :      45293 KiB/s,         58 cycles/byte
  HMAC_DRBG SHA-1 (PR)     :      41807 KiB/s,         63 cycles/byte
  HMAC_DRBG SHA-256 (NOPR) :      28153 KiB/s,         94 cycles/byte
  HMAC_DRBG SHA-256 (PR)   :      28640 KiB/s,        108 cycles/byte
  RSA-2048                 :    3941  public/s
  RSA-2048                 :     426 private/s
  RSA-3072                 :    1699  public/s
  RSA-3072                 :     160 private/s
  RSA-4096                 :     934  public/s
  RSA-4096                 :      73 private/s
  DHE-2048                 :      92 handshake/s
  DH-2048                  :     182 handshake/s
  DHE-3072                 :      27 handshake/s
  DH-3072                  :      52 handshake/s
  ECDSA-secp521r1          :    1348 sign/s
  ECDSA-brainpoolP512r1    :     201 sign/s
  ECDSA-secp384r1          :    1996 sign/s
  ECDSA-brainpoolP384r1    :     418 sign/s
  ECDSA-secp256r1          :    2879 sign/s
  ECDSA-secp256k1          :    2248 sign/s
  ECDSA-brainpoolP256r1    :     683 sign/s
  ECDSA-secp224r1          :    3958 sign/s
  ECDSA-secp224k1          :    2482 sign/s
  ECDSA-secp192r1          :    5235 sign/s
  ECDSA-secp192k1          :    3128 sign/s
  ECDSA-secp521r1          :     374 verify/s
  ECDSA-brainpoolP512r1    :      44 verify/s
  ECDSA-secp384r1          :     544 verify/s
  ECDSA-brainpoolP384r1    :      94 verify/s
  ECDSA-secp256r1          :     825 verify/s
  ECDSA-secp256k1          :     647 verify/s
  ECDSA-brainpoolP256r1    :     179 verify/s
  ECDSA-secp224r1          :    1186 verify/s
  ECDSA-secp224k1          :     728 verify/s
  ECDSA-secp192r1          :    1667 verify/s
  ECDSA-secp192k1          :     962 verify/s
  ECDHE-secp521r1          :     403 ephemeral handshake/s
  ECDHE-brainpoolP512r1    :      46 ephemeral handshake/s
  ECDHE-secp384r1          :     600 ephemeral handshake/s
  ECDHE-brainpoolP384r1    :     100 ephemeral handshake/s
  ECDHE-secp256r1          :     922 ephemeral handshake/s
  ECDHE-secp256k1          :     695 ephemeral handshake/s
  ECDHE-brainpoolP256r1    :     186 ephemeral handshake/s
  ECDHE-secp224r1          :    1311 ephemeral handshake/s
  ECDHE-secp224k1          :     746 ephemeral handshake/s
  ECDHE-secp192r1          :    1818 ephemeral handshake/s
  ECDHE-secp192k1          :     994 ephemeral handshake/s
  ECDHE-x25519             :     687 ephemeral handshake/s
  ECDHE-x448               :     285 ephemeral handshake/s
  ECDH-secp521r1           :     543 static handshake/s
  ECDH-brainpoolP512r1     :      60 static handshake/s
  ECDH-secp384r1           :     799 static handshake/s
  ECDH-brainpoolP384r1     :     128 static handshake/s
  ECDH-secp256r1           :    1238 static handshake/s
  ECDH-secp256k1           :     974 static handshake/s
  ECDH-brainpoolP256r1     :     254 static handshake/s
  ECDH-secp224r1           :    1775 static handshake/s
  ECDH-secp224k1           :    1037 static handshake/s
  ECDH-secp192r1           :    2454 static handshake/s
  ECDH-secp192k1           :    1313 static handshake/s
  ECDH-x25519              :    1232 static handshake/s
  ECDH-x448                :     629 static handshake/s

benshan@sev-snp-guest:~$ 
benshan@sev-snp-guest:~$ benchmark 

  MD5                      :     623826 KiB/s,          4 cycles/byte
  RIPEMD160                :     447429 KiB/s,          6 cycles/byte
  SHA-1                    :     665462 KiB/s,          4 cycles/byte
  SHA-256                  :     292374 KiB/s,          9 cycles/byte
  SHA-512                  :     324745 KiB/s,          8 cycles/byte
  SHA3-224                 :     154354 KiB/s,         17 cycles/byte
  SHA3-256                 :     153316 KiB/s,         17 cycles/byte
  SHA3-384                 :     124614 KiB/s,         21 cycles/byte
  SHA3-512                 :      85998 KiB/s,         31 cycles/byte
  3DES                     :      33373 KiB/s,         81 cycles/byte
  DES                      :      83993 KiB/s,         32 cycles/byte
  3DES-CMAC                :      32376 KiB/s,         84 cycles/byte
  AES-CBC-128              :     823276 KiB/s,          3 cycles/byte
  AES-CBC-192              :     740936 KiB/s,          3 cycles/byte
  AES-CBC-256              :     670587 KiB/s,          4 cycles/byte
  AES-CFB128-128           :     404587 KiB/s,          6 cycles/byte
  AES-CFB128-192           :     379300 KiB/s,          7 cycles/byte
  AES-CFB128-256           :     361203 KiB/s,          7 cycles/byte
  AES-CFB8-128             :      38139 KiB/s,         70 cycles/byte
  AES-CFB8-192             :      34435 KiB/s,         86 cycles/byte
  AES-CFB8-256             :      32104 KiB/s,         83 cycles/byte
  AES-CTR-128              :     905808 KiB/s,          2 cycles/byte
  AES-CTR-192              :     799213 KiB/s,          3 cycles/byte
  AES-CTR-256              :     724650 KiB/s,          3 cycles/byte
  AES-XTS-128              :     770419 KiB/s,          3 cycles/byte
  AES-XTS-256              :     638333 KiB/s,          6 cycles/byte
  AES-GCM-128              :     326852 KiB/s,          8 cycles/byte
  AES-GCM-192              :     312590 KiB/s,          8 cycles/byte
  AES-GCM-256              :     300440 KiB/s,          8 cycles/byte
  AES-CCM-128              :     491750 KiB/s,          5 cycles/byte
  AES-CCM-192              :     452013 KiB/s,          5 cycles/byte
  AES-CCM-256              :     420854 KiB/s,          6 cycles/byte
  ChaCha20-Poly1305        :     360653 KiB/s,          7 cycles/byte
  AES-CMAC-128             :     600275 KiB/s,          4 cycles/byte
  AES-CMAC-192             :     546693 KiB/s,          4 cycles/byte
  AES-CMAC-256             :     506473 KiB/s,          5 cycles/byte
  AES-CMAC-PRF-128         :     593230 KiB/s,          4 cycles/byte
  ARIA-CBC-128             :      97768 KiB/s,         27 cycles/byte
  ARIA-CBC-192             :      85640 KiB/s,         40 cycles/byte
  ARIA-CBC-256             :      76686 KiB/s,         34 cycles/byte
  CAMELLIA-CBC-128         :     106797 KiB/s,         24 cycles/byte
  CAMELLIA-CBC-192         :      81420 KiB/s,         38 cycles/byte
  CAMELLIA-CBC-256         :      81354 KiB/s,         32 cycles/byte
  ChaCha20                 :     511011 KiB/s,          5 cycles/byte
  Poly1305                 :    1492602 KiB/s,          1 cycles/byte
  CTR_DRBG (NOPR)          :     586997 KiB/s,          4 cycles/byte
  CTR_DRBG (PR)            :     408456 KiB/s,          6 cycles/byte
  HMAC_DRBG SHA-1 (NOPR)   :      45478 KiB/s,         58 cycles/byte
  HMAC_DRBG SHA-1 (PR)     :      41612 KiB/s,         63 cycles/byte
  HMAC_DRBG SHA-256 (NOPR) :      28391 KiB/s,         92 cycles/byte
  HMAC_DRBG SHA-256 (PR)   :      28609 KiB/s,        100 cycles/byte
  RSA-2048                 :    3932  public/s
  RSA-2048                 :     423 private/s
  RSA-3072                 :    1675  public/s
  RSA-3072                 :     155 private/s
  RSA-4096                 :     912  public/s
  RSA-4096                 :      73 private/s
  DHE-2048                 :      93 handshake/s
  DH-2048                  :     183 handshake/s
  DHE-3072                 :      27 handshake/s
  DH-3072                  :      52 handshake/s
  ECDSA-secp521r1          :    1349 sign/s
  ECDSA-brainpoolP512r1    :     199 sign/s
  ECDSA-secp384r1          :    1971 sign/s
  ECDSA-brainpoolP384r1    :     401 sign/s
  ECDSA-secp256r1          :    2800 sign/s
  ECDSA-secp256k1          :    2115 sign/s
  ECDSA-brainpoolP256r1    :     660 sign/s
  ECDSA-secp224r1          :    3838 sign/s
  ECDSA-secp224k1          :    2289 sign/s
  ECDSA-secp192r1          :    4999 sign/s
  ECDSA-secp192k1          :    2948 sign/s
  ECDSA-secp521r1          :     368 verify/s
  ECDSA-brainpoolP512r1    :      44 verify/s
  ECDSA-secp384r1          :     531 verify/s
  ECDSA-brainpoolP384r1    :      89 verify/s
  ECDSA-secp256r1          :     812 verify/s
  ECDSA-secp256k1          :     599 verify/s
  ECDSA-brainpoolP256r1    :     170 verify/s
  ECDSA-secp224r1          :    1118 verify/s
  ECDSA-secp224k1          :     652 verify/s
  ECDSA-secp192r1          :    1546 verify/s
  ECDSA-secp192k1          :     836 verify/s
  ECDHE-secp521r1          :     390 ephemeral handshake/s
  ECDHE-brainpoolP512r1    :      45 ephemeral handshake/s
  ECDHE-secp384r1          :     569 ephemeral handshake/s
  ECDHE-brainpoolP384r1    :      88 ephemeral handshake/s
  ECDHE-secp256r1          :     884 ephemeral handshake/s
  ECDHE-secp256k1          :     628 ephemeral handshake/s
  ECDHE-brainpoolP256r1    :     178 ephemeral handshake/s
  ECDHE-secp224r1          :    1240 ephemeral handshake/s
  ECDHE-secp224k1          :     669 ephemeral handshake/s
  ECDHE-secp192r1          :    1693 ephemeral handshake/s
  ECDHE-secp192k1          :     914 ephemeral handshake/s
  ECDHE-x25519             :     662 ephemeral handshake/s
  ECDHE-x448               :     273 ephemeral handshake/s
  ECDH-secp521r1           :     512 static handshake/s
  ECDH-brainpoolP512r1     :      57 static handshake/s
  ECDH-secp384r1           :     749 static handshake/s
  ECDH-brainpoolP384r1     :     114 static handshake/s
  ECDH-secp256r1           :    1173 static handshake/s
  ECDH-secp256k1           :     888 static handshake/s
  ECDH-brainpoolP256r1     :     241 static handshake/s
  ECDH-secp224r1           :    1631 static handshake/s
  ECDH-secp224k1           :     935 static handshake/s
  ECDH-secp192r1           :    2292 static handshake/s
  ECDH-secp192k1           :    1190 static handshake/s
  ECDH-x25519              :    1142 static handshake/s
  ECDH-x448                :     577 static handshake/s

benshan@sev-snp-guest:~$ 
```

## sqlite3

## wolfssl

### host

```bash
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/apps/wolfssl$ ./wolfcrypt/benchmark/benchmark

------------------------------------------------------------------------------
 wolfSSL version 5.7.0
------------------------------------------------------------------------------
Math:   Multi-Precision: Wolf(SP) word-size=64 bits=4096 sp_int.c
wolfCrypt Benchmark (block bytes 1048576, min 1.0 sec each)
RNG                        115 MiB took 1.022 seconds,  112.499 MiB/s Cycles per byte =  23.74
AES-128-CBC-enc            320 MiB took 1.013 seconds,  316.039 MiB/s Cycles per byte =   8.45
AES-128-CBC-dec            360 MiB took 1.006 seconds,  357.850 MiB/s Cycles per byte =   7.46
AES-192-CBC-enc            275 MiB took 1.018 seconds,  270.268 MiB/s Cycles per byte =   9.88
AES-192-CBC-dec            305 MiB took 1.007 seconds,  302.733 MiB/s Cycles per byte =   8.82
AES-256-CBC-enc            240 MiB took 1.008 seconds,  238.062 MiB/s Cycles per byte =  11.22
AES-256-CBC-dec            265 MiB took 1.011 seconds,  262.173 MiB/s Cycles per byte =  10.18
AES-128-GCM-enc            165 MiB took 1.022 seconds,  161.484 MiB/s Cycles per byte =  16.54
AES-128-GCM-dec            160 MiB took 1.004 seconds,  159.303 MiB/s Cycles per byte =  16.76
AES-192-GCM-enc            150 MiB took 1.004 seconds,  149.474 MiB/s Cycles per byte =  17.86
AES-192-GCM-dec            150 MiB took 1.017 seconds,  147.432 MiB/s Cycles per byte =  18.11
AES-256-GCM-enc            140 MiB took 1.015 seconds,  137.992 MiB/s Cycles per byte =  19.35
AES-256-GCM-dec            140 MiB took 1.020 seconds,  137.231 MiB/s Cycles per byte =  19.46
GMAC Table 4-bit           380 MiB took 1.002 seconds,  379.262 MiB/s Cycles per byte =   7.04
CHACHA                     550 MiB took 1.009 seconds,  545.234 MiB/s Cycles per byte =   4.90
CHA-POLY                   385 MiB took 1.003 seconds,  383.657 MiB/s Cycles per byte =   6.96
MD5                        700 MiB took 1.007 seconds,  695.327 MiB/s Cycles per byte =   3.84
POLY1305                  1315 MiB took 1.003 seconds, 1311.042 MiB/s Cycles per byte =   2.04
SHA                        760 MiB took 1.005 seconds,  755.912 MiB/s Cycles per byte =   3.53
SHA-224                    255 MiB took 1.012 seconds,  252.007 MiB/s Cycles per byte =  10.60
SHA-256                    255 MiB took 1.012 seconds,  252.023 MiB/s Cycles per byte =  10.60
SHA-384                    415 MiB took 1.000 seconds,  414.906 MiB/s Cycles per byte =   6.44
SHA-512                    415 MiB took 1.006 seconds,  412.446 MiB/s Cycles per byte =   6.47
SHA-512/224                415 MiB took 1.000 seconds,  414.950 MiB/s Cycles per byte =   6.44
SHA-512/256                415 MiB took 1.000 seconds,  414.890 MiB/s Cycles per byte =   6.44
SHA3-224                   465 MiB took 1.005 seconds,  462.719 MiB/s Cycles per byte =   5.77
SHA3-256                   440 MiB took 1.008 seconds,  436.666 MiB/s Cycles per byte =   6.11
SHA3-384                   335 MiB took 1.004 seconds,  333.593 MiB/s Cycles per byte =   8.00
SHA3-512                   235 MiB took 1.006 seconds,  233.628 MiB/s Cycles per byte =  11.43
HMAC-MD5                   700 MiB took 1.007 seconds,  695.342 MiB/s Cycles per byte =   3.84
HMAC-SHA                   760 MiB took 1.005 seconds,  756.211 MiB/s Cycles per byte =   3.53
HMAC-SHA224                255 MiB took 1.012 seconds,  252.007 MiB/s Cycles per byte =  10.60
HMAC-SHA256                255 MiB took 1.018 seconds,  250.414 MiB/s Cycles per byte =  10.66
HMAC-SHA384                420 MiB took 1.012 seconds,  415.059 MiB/s Cycles per byte =   6.43
HMAC-SHA512                415 MiB took 1.000 seconds,  414.972 MiB/s Cycles per byte =   6.43
PBKDF2                      31 KiB took 1.000 seconds,   30.892 KiB/s Cycles per byte = 88512.61
RSA     2048   public     29500 ops took 1.002 sec, avg 0.034 ms, 29428.434 ops/sec
RSA     2048  private       500 ops took 1.114 sec, avg 2.228 ms, 448.891 ops/sec
DH      2048  key gen      2518 ops took 1.000 sec, avg 0.397 ms, 2517.956 ops/sec
DH      2048    agree      1200 ops took 1.036 sec, avg 0.863 ms, 1158.523 ops/sec
ECC   [      SECP256R1]   256  key gen      2500 ops took 1.036 sec, avg 0.415 ms, 2412.047 ops/sec
ECDHE [      SECP256R1]   256    agree      2500 ops took 1.032 sec, avg 0.413 ms, 2423.282 ops/sec
ECDSA [      SECP256R1]   256     sign      2400 ops took 1.025 sec, avg 0.427 ms, 2341.834 ops/sec
ECDSA [      SECP256R1]   256   verify      3200 ops took 1.013 sec, avg 0.316 ms, 3160.078 ops/sec
Benchmark complete
```

```bash
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/apps/wolfssl$ strace -o benchmark.strace ./wolfcrypt/benchmark/.libs/benchmark -csv
------------------------------------------------------------------------------
 wolfSSL version 5.7.0
------------------------------------------------------------------------------
Math:   Multi-Precision: Wolf(SP) word-size=64 bits=4096 sp_int.c
        Single Precision: ecc 256 384 521 rsa/dh 2048 3072 4096 asm sp_x86_64.c
wolfCrypt Benchmark (block bytes 1048576, min 1.0 sec each)
This format allows you to easily copy the output to a csv file.

Symmetric Ciphers:

Algorithm,MB/s,Cycles per byte,
RNG,400.939657,6.659867,
AES-128-CBC-enc,1306.732160,2.043421,
AES-128-CBC-dec,10188.350646,0.262084,
AES-192-CBC-enc,1104.325973,2.417949,
AES-192-CBC-dec,8448.420820,0.316059,
AES-256-CBC-enc,951.811413,2.805393,
AES-256-CBC-dec,7309.397027,0.365311,
AES-128-GCM-enc,4677.385581,0.570875,
AES-128-GCM-dec,4704.552461,0.567579,
AES-192-GCM-enc,4373.988445,0.610473,
AES-192-GCM-dec,4457.779774,0.598999,
AES-256-GCM-enc,3958.055088,0.674625,
AES-256-GCM-dec,3979.815921,0.670937,
AES-128-GCM-STREAM-enc,4657.523718,0.573310,
AES-128-GCM-STREAM-dec,4699.340079,0.568208,
AES-192-GCM-STREAM-enc,4390.569970,0.608168,
AES-192-GCM-STREAM-dec,4465.200843,0.598003,
AES-256-GCM-STREAM-enc,4108.490528,0.649923,
AES-256-GCM-STREAM-dec,4113.679873,0.649103,
GMAC Table 4-bit,2133.525409,1.251545,
AES-128-ECB-enc,10899.794197,0.244977,
AES-128-ECB-dec,10778.617435,0.247732,
AES-192-ECB-enc,8128.195766,0.328511,
AES-192-ECB-dec,8081.327636,0.330416,
AES-256-ECB-enc,7454.463208,0.358202,
AES-256-ECB-dec,7523.628689,0.354909,
AES-XTS-enc,6975.970064,0.382772,
AES-XTS-dec,6824.119795,0.391289,
AES-128-CFB,713.886017,3.740380,
AES-192-CFB,643.789414,4.147635,
AES-256-CFB,593.193677,4.501402,
AES-128-OFB,955.687187,2.794015,
AES-192-OFB,831.386881,3.211746,
AES-256-OFB,683.510693,3.906602,
AES-128-CTR,1628.141786,1.640031,
AES-192-CTR,1555.284795,1.716858,
AES-256-CTR,1506.037692,1.772998,
AES-CCM-enc,536.769252,4.974584,
AES-CCM-dec,535.612738,4.985321,
AES-256-SIV-enc,520.555739,5.129527,
AES-256-SIV-dec,518.220953,5.152636,
AES-384-SIV-enc,477.780883,5.588763,
AES-384-SIV-dec,477.176399,5.595840,
AES-512-SIV-enc,439.164663,6.080186,
AES-512-SIV-dec,445.112711,5.998940,
Camellia,180.065097,14.829104,
ARC4,381.367002,7.001663,
CHACHA,3615.921391,0.738458,
CHA-POLY,2392.760301,1.115951,
3DES,32.984438,80.953423,
MD5,694.372726,3.845488,
POLY1305,6963.411182,0.383462,
SHA,745.043528,3.583957,
SHA-224,1739.215046,1.535291,
SHA-256,1739.363026,1.535162,
SHA-384,778.705593,3.429029,
SHA-512,775.286511,3.444152,
SHA-512/224,774.289271,3.448588,
SHA-512/256,773.741332,3.451030,
SHA3-224,477.282396,5.594602,
SHA3-256,449.790992,5.936544,
SHA3-384,344.877813,7.742458,
SHA3-512,238.074653,11.215827,
SHAKE128,553.840769,4.821243,
SHAKE256,451.076116,5.919629,
RIPEMD,285.609598,9.349142,
BLAKE2b,533.070080,5.009104,
BLAKE2s,393.394833,6.787589,
AES-128-CMAC,767.355432,3.479746,
AES-256-CMAC,631.216138,4.230252,
HMAC-MD5,693.061255,3.852766,
HMAC-SHA,743.244093,3.592635,
HMAC-SHA224,1749.117164,1.526599,
HMAC-SHA256,1747.657875,1.527875,
HMAC-SHA384,773.964247,3.450033,
HMAC-SHA512,777.352486,3.434997,
PBKDF2,188.112263,14535.399709,
SipHash-8,3143.483832,0.849441,
SipHash-16,3140.601679,0.850221,

Asymmetric Ciphers:

Algorithm,key size,operation,avg ms,ops/sec,
KDF,128,SRTP,0.000,6264459.026,
KDF,256,SRTP,0.000,4827287.698,
KDF,128,SRTCP,0.000,6274718.504,
KDF,256,SRTCP,0.000,4824411.549,
scrypt,17,,44.080,22.686,
RSA,1024,key gen,12.781,78.240,
RSA,2048,key gen,36.508,27.391,
RSA,2048,public,0.014,71522.685,
RSA,2048,private,0.527,1895.784,
DH,2048,key gen,0.255,3919.650,
DH,2048,agree,0.254,3931.542,
ECC   [      SECP256R1],256,key gen,0.016,63765.444,
ECDHE [      SECP256R1],256,agree,0.022,45877.402,
ECDSA [      SECP256R1],256,sign,0.021,46800.548,
ECDSA [      SECP256R1],256,verify,0.022,46320.034,
ECC   [      SECP256R1],256,encrypt,0.024,41458.643,
ECC   [      SECP256R1],256,decrypt,0.024,41115.002,
ECC   [BRAINPOOLP256R1],256,key gen,0.079,12705.076,
ECDHE [BRAINPOOLP256R1],256,agree,0.076,13175.978,
ECDSA [BRAINPOOLP256R1],256,sign,0.091,11007.914,
ECDSA [BRAINPOOLP256R1],256,verify,0.101,9904.710,
ECC   [BRAINPOOLP256R1],256,encrypt,0.077,13016.001,
ECC   [BRAINPOOLP256R1],256,decrypt,0.077,13041.229,
CURVE,25519,key gen,0.028,35659.872,
CURVE,25519,agree,0.028,35909.565,
ED,25519,key gen,0.010,97018.422,
ED,25519,sign,0.012,85377.690,
ED,25519,verify,0.037,27357.291,
CURVE,448,key gen,0.144,6932.828,
CURVE,448,agree,0.145,6892.845,
ED,448,key gen,0.061,16328.397,
ED,448,sign,0.064,15531.413,
ED,448,verify,0.174,5751.917,
ECCSI,256,key gen,0.016,61030.127,
ECCSI,256,pair gen,0.017,59300.265,
ECCSI,256,valid,0.031,32766.852,
ECCSI,256,sign,0.028,36235.948,
ECCSI,256,verify,0.070,14367.836,
SAKKE,1024,key gen,0.859,1163.595,
SAKKE,1024,rsk gen,0.861,1161.677,
SAKKE,1024,valid,6.147,162.682,
SAKKE,1024,encap-1,1.226,815.632,
SAKKE,1024,derive-1,6.108,163.717,
SAKKE,1024,encap-2,1.149,870.323,
SAKKE,1024,derive-2,6.083,164.381,
SAKKE,1024,derive-3,2.915,343.097,
SAKKE,1024,derive-4,2.918,342.723,
Benchmark complete
```

### guest

```bash
benshan@sev-snp-guest:~/vmpl-bench/apps/wolfssl$ wolfcrypt/benchmark/.libs/benchmark -csv
------------------------------------------------------------------------------
 wolfSSL version 5.7.0
------------------------------------------------------------------------------
Math: 	Multi-Precision: Wolf(SP) word-size=64 bits=4096 sp_int.c
	Single Precision: ecc 256 384 521 rsa/dh 2048 3072 4096 asm sp_x86_64.c
wolfCrypt Benchmark (block bytes 1048576, min 1.0 sec each)
This format allows you to easily copy the output to a csv file.

Symmetric Ciphers:

Algorithm,MB/s,Cycles per byte,
RNG,379.695740,7.032578,
AES-128-CBC-enc,1292.739873,2.065568,
AES-128-CBC-dec,9881.711047,0.270221,
AES-192-CBC-enc,1068.528014,2.498992,
AES-192-CBC-dec,8383.127224,0.318526,
AES-256-CBC-enc,919.904595,2.902739,
AES-256-CBC-dec,7217.759456,0.369955,
AES-128-GCM-enc,4480.940310,0.595911,
AES-128-GCM-dec,4560.667667,0.585494,
AES-192-GCM-enc,4283.236382,0.623415,
AES-192-GCM-dec,4278.121190,0.624163,
AES-256-GCM-enc,3938.563289,0.677973,
AES-256-GCM-dec,3903.227203,0.684112,
AES-128-GCM-STREAM-enc,4538.071946,0.588409,
AES-128-GCM-STREAM-dec,4508.546706,0.592263,
AES-192-GCM-STREAM-enc,4287.654943,0.622775,
AES-192-GCM-STREAM-dec,4307.855472,0.619852,
AES-256-GCM-STREAM-enc,3887.810600,0.686825,
AES-256-GCM-STREAM-dec,3981.623365,0.670642,
GMAC Table 4-bit,2045.783925,1.305241,
AES-128-ECB-enc,10181.218039,0.262271,
AES-128-ECB-dec,10109.972714,0.264120,
AES-192-ECB-enc,7575.728982,0.352473,
AES-192-ECB-dec,8169.215633,0.326867,
AES-256-ECB-enc,6867.684171,0.388813,
AES-256-ECB-dec,7099.921323,0.376095,
AES-XTS-enc,6574.774273,0.406134,
AES-XTS-dec,6775.380023,0.394110,
AES-128-CFB,678.948305,3.932908,
AES-192-CFB,615.974427,4.334989,
AES-256-CFB,572.470747,4.664419,
AES-128-OFB,908.560575,2.938978,
AES-192-OFB,798.259904,3.345080,
AES-256-OFB,659.564725,4.048492,
AES-128-CTR,1533.596316,1.741165,
AES-192-CTR,1484.758222,1.798437,
AES-256-CTR,1428.845492,1.868812,
AES-CCM-enc,513.529190,5.199788,
AES-CCM-dec,519.249779,5.142502,
AES-256-SIV-enc,493.290427,5.413127,
AES-256-SIV-dec,493.918204,5.406247,
AES-384-SIV-enc,459.652491,5.809264,
AES-384-SIV-dec,456.218145,5.852996,
AES-512-SIV-enc,424.460709,6.290908,
AES-512-SIV-dec,422.562433,6.319169,
Camellia,171.255597,15.592152,
ARC4,369.958896,7.217676,
CHACHA,3413.382138,0.782286,
CHA-POLY,2254.944216,1.184172,
3DES,31.204442,85.572073,
MD5,664.981609,4.015509,
POLY1305,6607.036973,0.404151,
SHA,714.141186,3.739095,
SHA-224,1659.744764,1.608828,
SHA-256,1665.577842,1.603193,
SHA-384,749.334688,3.563482,
SHA-512,735.868627,3.628693,
SHA-512/224,737.425878,3.621033,
SHA-512/256,742.993673,3.593895,
SHA3-224,455.773372,5.858703,
SHA3-256,434.851120,6.140588,
SHA3-384,328.979094,8.116752,
SHA3-512,228.448093,11.688605,
SHAKE128,536.099437,4.980870,
SHAKE256,429.297044,6.220028,
RIPEMD,274.604622,9.723949,
BLAKE2b,513.242571,5.202691,
BLAKE2s,379.176882,7.042212,
AES-128-CMAC,743.208738,3.592857,
AES-256-CMAC,605.394056,4.410753,
HMAC-MD5,663.314001,4.025606,
HMAC-SHA,721.182686,3.702587,
HMAC-SHA224,1668.963837,1.599940,
HMAC-SHA256,1670.823245,1.598159,
HMAC-SHA384,746.623350,3.576426,
HMAC-SHA512,742.485751,3.596358,
PBKDF2,184.091291,14853.108530,
SipHash-8,2989.740537,0.893135,
SipHash-16,2986.008976,0.894252,

Asymmetric Ciphers:

Algorithm,key size,operation,avg ms,ops/sec,
KDF,128,SRTP,0.000,6002403.412,
KDF,256,SRTP,0.000,4652697.781,
KDF,128,SRTCP,0.000,5984990.719,
KDF,256,SRTCP,0.000,4660893.333,
scrypt,17,,49.171,20.337,
RSA,1024,key gen,12.568,79.569,
RSA,2048,key gen,34.069,29.352,
RSA,2048,public,0.015,67949.892,
RSA,2048,private,0.554,1804.287,
DH,2048,key gen,0.266,3764.920,
DH,2048,agree,0.264,3792.781,
ECC   [      SECP256R1],256,key gen,0.017,59876.443,
ECDHE [      SECP256R1],256,agree,0.023,44245.504,
ECDSA [      SECP256R1],256,sign,0.023,43663.356,
ECDSA [      SECP256R1],256,verify,0.023,44366.511,
ECC   [      SECP256R1],256,encrypt,0.025,39292.871,
ECC   [      SECP256R1],256,decrypt,0.026,39161.234,
ECC   [BRAINPOOLP256R1],256,key gen,0.080,12442.447,
ECDHE [BRAINPOOLP256R1],256,agree,0.080,12534.151,
ECDSA [BRAINPOOLP256R1],256,sign,0.097,10358.316,
ECDSA [BRAINPOOLP256R1],256,verify,0.105,9549.426,
ECC   [BRAINPOOLP256R1],256,encrypt,0.082,12229.895,
ECC   [BRAINPOOLP256R1],256,decrypt,0.081,12277.361,
CURVE,25519,key gen,0.029,33919.822,
CURVE,25519,agree,0.029,34128.875,
ED,25519,key gen,0.011,92921.490,
ED,25519,sign,0.012,81279.323,
ED,25519,verify,0.039,25401.291,
CURVE,448,key gen,0.149,6691.089,
CURVE,448,agree,0.151,6634.741,
ED,448,key gen,0.064,15732.415,
ED,448,sign,0.067,14859.124,
ED,448,verify,0.180,5548.694,
ECCSI,256,key gen,0.017,57777.091,
ECCSI,256,pair gen,0.018,56525.663,
ECCSI,256,valid,0.032,31254.446,
ECCSI,256,sign,0.029,34528.605,
ECCSI,256,verify,0.072,13807.816,
SAKKE,1024,key gen,0.829,1206.286,
SAKKE,1024,rsk gen,0.889,1124.747,
SAKKE,1024,valid,6.383,156.655,
SAKKE,1024,encap-1,1.270,787.146,
SAKKE,1024,derive-1,6.402,156.211,
SAKKE,1024,encap-2,1.208,828.080,
SAKKE,1024,derive-2,6.306,158.569,
SAKKE,1024,derive-3,3.014,331.771,
SAKKE,1024,derive-4,3.038,329.126,
Benchmark complete
benshan@sev-snp-guest:~/vmpl-bench/apps/wolfssl$
```
