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

## SPEC CPU 2017

[SPEC-cpu2006的详细使用一键安装、手动安装。](https://blog.csdn.net/weixin_42480467/article/details/121903703)

```bash
echo 1800 > /proc/sys/vm/nr_hugepages
export HUGETLB_MORECORE=yes
export LD_PRELOAD=/usr/lib/libhugetlbfs.so
source /home/cpu2006-1.2/shrc
ulimit -s unlimited
```

```bash
# RateInt测试, 8为CPU核数
echo 3 > /proc/sys/vm/drop_caches
runspec -c 920-8-cpu2006-int.cfg  int --rate 8 -n 1 --noreportable
sleep 10

# RateFp测试
echo 3 > /proc/sys/vm/drop_caches
runspec  -c  920-8-cpu2006-fp.cfg  fp  --rate 8 -n 1 --noreportable
sleep 10

# SpeedInt测试
echo 3 > /proc/sys/vm/drop_caches
runspec  -c  920-8-cpu2006-int.cfg  int --speed -n 1 --noreportable
sleep 10

# SpeedFp测试
echo 3 > /proc/sys/vm/drop_caches
runspec  -c  920-8-cpu2006-fp.cfg  fp --speed -n 1 --noreportable

# 删除测试过程中的文件，避免多次测试后硬盘容量不足
rm -fr /cpu2006-1/benchspec/CPU2006/*/run/*

# 单独测试某一项
runspec -c 920-8-cpu2006-int.cfg  429.gcf --rate 8 -n 1 –noreportable

# 测试完成后，可进入/home/cpu2006-1.2/result查看测试结果
# CINT2006.XXX.txt或CFP2006.XXX.txt文件。
# 测试过程中，如果想提前知道已经完成的测试子项分数，可使用如下命令进行查看，ratio即为得分：
# less CPU2006.XXX.log.debug | grep Success
```

[CPU计算性能speccpu2006的测试方法及工具下载](https://blog.csdn.net/wkl_venus/article/details/127688671)

```bash
# 打开终端，安装依赖包：
sudo apt-get install gcc g++ gfortran libbz2-dev
# 解压缩speccpu2006测试工具包：
tar xvf speccpu2006-v1.0.1-newest.tar > /dev/null
# 并附执行权限：
chmod -R a+x speccpu2006-v1.0.1
# 进入解压后的目录：
cd speccpu2006-v1.0.1
# 编辑 tools/src/buildtools 文件（311行和312行）
```

<!-- draw table -->
| SPEC 2006 | 说明 |
| --- | --- |
| 401.bzip2 | musl-libc (MonGuard) |
| 403.gcc | musl-libc (MonGuard) |
| 445.gobmk | musl-libc |
| 464.h264ref | musl-libc (MonGuard) |
| 456.hmmer | musl-libc |
| 470.lbm | musl-libc |
| 462.libquantum | musl-libc |
| 429.mcf | musl-libc (MonGuard) |
| 433.milc | musl-libc |
| 458.sjeng | musl-libc (MonGuard) |
| 482.sphinx3 | musl-libc |
| --- | --- |
| 400.perlbench | --- |
| 410.bwaves | --- |
| 416.gamess | --- |
| 434.zeusmp | --- |
| 435.gromacs | --- |
| 436.cactusADM | --- |
| 437.leslie3d | --- |
| 444.namd | --- |
| 447.dealII | --- |
| 450.soplex | --- |
| 453.povray | --- |
| 454.calculix | --- |
| 459.GemsFDTD | --- |
| 465.tonto | --- |
| 471.omnetpp | --- |
| 473.astar | --- |
| 481.wrf | --- |
| 483.xalancbmk | --- |
| 998.specrand | --- |
| 999.specrand | --- |
| SPEC CPU 2006 Mean | --- |
| | |

[SPEC CPU简介和使用](https://blog.csdn.net/qq_36287943/article/details/103601539)

[SpecCPU2017 测试cpu性能](https://www.cnblogs.com/xiaoqi-home/p/15981359.html)

[speccpu2017的安装与运行](https://blog.csdn.net/weixin_45520085/article/details/131303231)

[Install / execute spec cpu2006 benchmark](https://sjp38.github.io/post/spec_cpu2006_install/)
