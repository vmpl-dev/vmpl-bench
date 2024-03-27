# Benchmarks

## libc-bench

> 只有一个benchmark是多线程相关，其余不是。静态编译

```bash
# 编译有问题，libdict.a中的函数未定义
./scripts/build-libc-bench.sh
```

## ipc-bench

> 子进程都运行在VMPL环境中，因此IPC性能测试的结果可能会受到VMPL的影响。采用子进程通信的方式进行测试，可能需要改成子线程通信模式。

```bash
# Build IPC benchmarks
./scripts/build-ipc-bench.sh
```

```bash
# Run IPC benchmarks
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/bench$ ./scripts/run-ipc-bench.sh
~/vmpl-process/vmpl-bench/bench/ipc-bench/build ~/vmpl-process/vmpl-bench/bench
======================================== Testing PIPE performance
message size: 1000 octets
roundtrip count: 1000
average latency: 2226 ns
message size: 1000 octets
message count: 1000
average throughput: 1011122 msg/s
average throughput: 8088 Mb/s
======================================== Testing TCP performance
message size: 1000 octets
roundtrip count: 1000
average latency: 5982 ns
message size: 1000 octets
message count: 1000
average throughput: 217296 msg/s
average throughput: 1738 Mb/s
======================================== Testing UDP performance
message size: 1000 octets
roundtrip count: 1000
average latency: 8449 ns
======================================== Testing UNIX performance
message size: 1000 octets
roundtrip count: 1000
average latency: 3521 ns
message size: 1000 octets
message count: 1000
average throughput: 407331 msg/s
average throughput: 3258 Mb/s
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/bench
```

## nbench

> 不依赖pthread，不依赖fork和clone，应该可以跑

```bash
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/bench/nbench$ ./nbench --help
Usage: ./nbench [-v] [-c<FILE>]
 -v = verbose
 -c = input parameters thru command file <FILE>
$ ./nbench
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/bench/nbench$ ./nbench

BYTEmark* Native Mode Benchmark ver. 2 (10/95)
Index-split by Andrew D. Balsa (11/97)
Linux/Unix* port by Uwe F. Mayer (12/96,11/97)

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          1135.5  :      29.12  :       9.56
STRING SORT         :           204.4  :      91.33  :      14.14
BITFIELD            :      4.9904e+08  :      85.60  :      17.88
FP EMULATION        :          97.338  :      46.71  :      10.78
FOURIER             :      1.7079e+05  :     194.24  :     109.09
ASSIGNMENT          :          25.404  :      96.67  :      25.07
IDEA                :           11774  :     180.09  :      53.47
HUFFMAN             :          3003.8  :      83.30  :      26.60
NEURAL NET          :          31.751  :      51.01  :      21.46
LU DECOMPOSITION    :          843.92  :      43.72  :      31.57
==========================ORIGINAL BYTEMARK RESULTS==========================
INTEGER INDEX       : 76.561
FLOATING-POINT INDEX: 75.658
Baseline (MSDOS*)   : Pentium* 90, 256 KB L2-cache, Watcom* compiler 10.0
==============================LINUX DATA BELOW===============================
CPU                 : 128 CPU AuthenticAMD AMD EPYC 7543 32-Core Processor 1500MHz
L2 Cache            : 512 KB
OS                  : Linux 6.5.0-rc2-snp-host-ec25de0e7141
C compiler          : musl-gcc
libc                : 
MEMORY INDEX        : 18.506
INTEGER INDEX       : 19.567
FLOATING-POINT INDEX: 41.963
Baseline (LINUX)    : AMD K6/233*, 512 KB L2-cache, gcc 2.7.2.3, libc-5.4.38
* Trademarks are property of their respective holder.
benshan@public-Super-Server:~/vmpl-process/vmpl-bench/bench/nbench$
benshan@sev-snp-guest:~/vmpl-bench/bench/nbench$ ./nbench

BYTEmark* Native Mode Benchmark ver. 2 (10/95)
Index-split by Andrew D. Balsa (11/97)
Linux/Unix* port by Uwe F. Mayer (12/96,11/97)

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          1133.8  :      29.08  :       9.55
STRING SORT         :          201.27  :      89.93  :      13.92
BITFIELD            :      4.9934e+08  :      85.65  :      17.89
FP EMULATION        :          97.013  :      46.55  :      10.74
FOURIER             :      1.7125e+05  :     194.76  :     109.39
ASSIGNMENT          :          25.514  :      97.09  :      25.18
IDEA                :           11761  :     179.89  :      53.41
HUFFMAN             :          3017.9  :      83.69  :      26.72
NEURAL NET          :          31.677  :      50.89  :      21.40
LU DECOMPOSITION    :          842.74  :      43.66  :      31.53
==========================ORIGINAL BYTEMARK RESULTS==========================
INTEGER INDEX       : 76.432
FLOATING-POINT INDEX: 75.632
Baseline (MSDOS*)   : Pentium* 90, 256 KB L2-cache, Watcom* compiler 10.0
==============================LINUX DATA BELOW===============================
CPU                 : 64 CPU AuthenticAMD AMD EPYC-v4 Processor 2800MHz
L2 Cache            : 512 KB
OS                  : Linux 6.5.0-snp-guest-525dfdeadc3a
C compiler          : musl-gcc
libc                : 
MEMORY INDEX        : 18.441
INTEGER INDEX       : 19.561
FLOATING-POINT INDEX: 41.948
Baseline (LINUX)    : AMD K6/233*, 512 KB L2-cache, gcc 2.7.2.3, libc-5.4.38
* Trademarks are property of their respective holder.
benshan@sev-snp-guest:~/vmpl-bench/bench/nbench$
benshan@sev-snp-guest:~/vmpl-bench/bench/nbench$ strace --output=nbench.txt ./nbench

BYTEmark* Native Mode Benchmark ver. 2 (10/95)
Index-split by Andrew D. Balsa (11/97)
Linux/Unix* port by Uwe F. Mayer (12/96,11/97)

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          1065.1  :      27.32  :       8.97
STRING SORT         :           200.6  :      89.63  :      13.87
BITFIELD            :      4.8275e+08  :      82.81  :      17.30
FP EMULATION        :          95.517  :      45.83  :      10.58
FOURIER             :      1.6302e+05  :     185.41  :     104.13
ASSIGNMENT          :          25.404  :      96.67  :      25.07
IDEA                :           11615  :     177.65  :      52.74
HUFFMAN             :          3008.5  :      83.43  :      26.64
NEURAL NET          :          31.506  :      50.61  :      21.29
LU DECOMPOSITION    :          798.41  :      41.36  :      29.87
==========================ORIGINAL BYTEMARK RESULTS==========================
INTEGER INDEX       : 74.972
FLOATING-POINT INDEX: 72.941
Baseline (MSDOS*)   : Pentium* 90, 256 KB L2-cache, Watcom* compiler 10.0
==============================LINUX DATA BELOW===============================
CPU                 : 64 CPU AuthenticAMD AMD EPYC-v4 Processor 2800MHz
L2 Cache            : 512 KB
OS                  : Linux 6.5.0-snp-guest-525dfdeadc3a
C compiler          : musl-gcc
libc                : 
MEMORY INDEX        : 18.188
INTEGER INDEX       : 19.108
FLOATING-POINT INDEX: 40.456
Baseline (LINUX)    : AMD K6/233*, 512 KB L2-cache, gcc 2.7.2.3, libc-5.4.38
* Trademarks are property of their respective holder.
benshan@sev-snp-guest:~/vmpl-bench/bench/nbench$ 
```

```bash
# 编译
./scripts/build-nbench.sh
```

```bash
# 运行

```

## lmbench

### lmbench-2.5

> 依赖`rpc/rpc.h`，编译失败。lmbench包含大量的fork操作，因此在测试时可能会导致系统崩溃。

```bash
# 查看系统调用
grep -E 'fork|thread|mmap|brk' lmbench/src/*.{c,h}
```

```bash
./scripts/build-lmbench.sh
```

## unixbench

> 每一个benchmark都有fork

```bash
# 查看系统调用
grep -En 'fork|thread|mmap|brk' unixbench/UnixBench/src/*.{c,h}
```

```bash
# 编译
./scripts/build-unixbench.sh
```
