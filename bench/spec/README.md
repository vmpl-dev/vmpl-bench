
# SPEC CPU Benchmark

```bash
export SPEC_HOME=$HOME/speccpu
export SPEC_CPU2006_1_0=$SPEC_HOME/speccpu2006/speccpu2006-v1.0.1
export SPEC_CPU2006_1_2=$SPEC_HOME/cpu2006-1.2
export SPEC_CPU2017=$SPEC_HOME/speccpu2017/cpu2017-1.0.5
```

## SPEC CPU 2000

[SPEC 2000使用的详细介绍（1）](https://blog.csdn.net/weixin_46804051/article/details/126727245)

```bash
# 1. 下载SPEC2000测试工具包
tar -zxvf spec2000-new.tar.gz
# 2. 进入SPEC2000目录
cd /home/benchmark/spec2000-new
# 3. 安装SPEC2000测试工具
. shrc
# 4. 进入测试工具目录
runspec -c test.cfg -i ref -n 3 -I -r -u 4 all
# 5. 运行测试
runspec -c test.cfg -i test -I all
runspec -c test.cfg -i ref -n 3 -I all
runspec -c test.cfg -i ref -n 3 －r -u 4 -I all
runspec -c test.cfg -i ref -n 3 －r -u 8 -I all
runspec -c test.cfg -i ref -n 3 －r -u 8 -I int
runspec -c test.cfg -i ref -n 3 －r -u 8 -I 164
runspec -c test.cfg -i test -n 1 -D -I -a build 164
```

## SPEC CPU 2006

[SPEC-cpu2006的详细使用一键安装、手动安装。](https://blog.csdn.net/weixin_42480467/article/details/121903703)

```bash
# musl-libc spec 2006 config
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
runspec -c 920-8-cpu2006-int.cfg  429.gcf --rate 8 -n 1 –-noreportable

# 测试完成后，可进入/home/cpu2006-1.2/result查看测试结果
# CINT2006.XXX.txt或CFP2006.XXX.txt文件。
# 测试过程中，如果想提前知道已经完成的测试子项分数，可使用如下命令进行查看，ratio即为得分：
# less CPU2006.XXX.log.debug | grep Success
```

[CPU计算性能speccpu2006的测试方法及工具下载](https://blog.csdn.net/wkl_venus/article/details/127688671)

```bash
# 1. 打开终端，安装依赖包：
sudo apt-get install gcc g++ gfortran libbz2-dev
# 2. 解压缩speccpu2006测试工具包：
tar xvf speccpu2006-v1.0.1-newest.tar > /dev/null
# 3. 并附执行权限：
chmod -R a+x speccpu2006-v1.0.1
# 4. 进入解压后的目录：
cd speccpu2006-v1.0.1
# 5. 安装speccpu2006测试工具：
./install.sh
# 6. 加载环境变量
. ./shrc （注意这里是：.空格./shrc）
# 7. 检查SPEC CPU2006是否安装成功
runspec --version
# 8.选择相应配置文件进行测试：
runspec -c x86.cfg -n 1 -r 1 all #（单线程）
runspec -c x86.cfg -n 1 -r N all #（多线程）
```

```bash
runspec --version
```

<!-- draw table -->
| SPEC 2006 | 说明 |
| --- | --- |
| 400.perlbench | --- |
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
| 473.astar | --- |
| 482.sphinx3 | musl-libc |
|||

| SPEC 2006 | 说明 |
| --- | --- |
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
| 481.wrf | --- |
| 483.xalancbmk | --- |
| 998.specrand | --- |
| 999.specrand | --- |
| | |

## SPEC CPU 2017

[SPEC CPU简介和使用](https://blog.csdn.net/qq_36287943/article/details/103601539)

```bash
# runcpu测试500 benchmark，test.cfg配置文件，test数据集，运行一次
runcpu -c test.cfg -a run --rebuild -i test -n 1 --noreportable 500
```

[SpecCPU2017 测试cpu性能](https://www.cnblogs.com/xiaoqi-home/p/15981359.html)

```bash
# 3、测试步骤
# a．Speccpu2017 安装完成需执行命令
source shrc
runcpu --config=spec17-opti-gcc7.3.cfg all --tune=all –reportable
runcpu --config=spec17-opti-gcc7.3.cfg all --threads 98 --copies=98 --tune=all –reportable
```

[speccpu2017的安装与运行](https://blog.csdn.net/weixin_45520085/article/details/131303231)

安装SPEC CPU 2017

```bash
$ cd ~/speccpu/speccpu2017
$ sudo mount cpu2017-1.0.5.iso /mnt/cdrom -o uid=1001,gid=1001
$ cd /mnt/cdrom
$ ./install.sh
SPEC CPU2017 Installation

Top of the CPU2017 tree is '/mnt/cdrom'
Enter the directory you wish to install to (e.g. /usr/cpu2017)
/home/benshan/speccpu/speccpu2017/cpu2017-1.0.5

Installing FROM /mnt/cdrom
Installing TO /home/benshan/speccpu/speccpu2017/cpu2017-1.0.5

Is this correct? (Please enter 'yes' or 'no') 
yes

The following toolset is expected to work on your platform.  If the
automatically installed one does not work, please re-run install.sh and
exclude that toolset using the '-e' switch.

The toolset selected will not affect your benchmark scores.

linux-x86_64                  For x86_64 Linux systems
                              Built on Oracle Linux 6.0 with
                              GCC v4.4.4 20100726 (Red Hat 4.4.4-13)



=================================================================
Attempting to install the linux-x86_64 toolset...


Unpacking CPU2017 base files (44 MB)
Unpacking CPU2017 tools binary files (150.2 MB)
Unpacking 500.perlbench_r benchmark and data files (102 MB)
Unpacking 502.gcc_r benchmark and data files (240.3 MB)
Unpacking 503.bwaves_r benchmark and data files (0.2 MB)
Unpacking 505.mcf_r benchmark and data files (8.5 MB)
Unpacking 507.cactuBSSN_r benchmark and data files (12.5 MB)
Unpacking 508.namd_r benchmark and data files (8.3 MB)
Unpacking 510.parest_r benchmark and data files (25.6 MB)
Unpacking 511.povray_r benchmark and data files (23.3 MB)
Unpacking 519.lbm_r benchmark and data files (4.3 MB)
Unpacking 520.omnetpp_r benchmark and data files (56.6 MB)
Unpacking 521.wrf_r benchmark and data files (217.2 MB)
Unpacking 523.xalancbmk_r benchmark and data files (212 MB)
Unpacking 525.x264_r benchmark and data files (57.9 MB)
Unpacking 526.blender_r benchmark and data files (215.7 MB)
Unpacking 527.cam4_r benchmark and data files (348.6 MB)
Unpacking 531.deepsjeng_r benchmark and data files (0.5 MB)
Unpacking 538.imagick_r benchmark and data files (80.7 MB)
Unpacking 541.leela_r benchmark and data files (3.8 MB)
Unpacking 544.nab_r benchmark and data files (38.6 MB)
Unpacking 548.exchange2_r benchmark and data files (0.1 MB)
Unpacking 549.fotonik3d_r benchmark and data files (5.2 MB)
Unpacking 554.roms_r benchmark and data files (11.4 MB)
Unpacking 557.xz_r benchmark and data files (104.1 MB)
Unpacking 600.perlbench_s benchmark and data files (3.1 MB)
Unpacking 602.gcc_s benchmark and data files (0.9 MB)
Unpacking 603.bwaves_s benchmark and data files (0 MB)
Unpacking 605.mcf_s benchmark and data files (0.1 MB)
Unpacking 607.cactuBSSN_s benchmark and data files (0.1 MB)
Unpacking 619.lbm_s benchmark and data files (30.4 MB)
Unpacking 620.omnetpp_s benchmark and data files (0.1 MB)
Unpacking 621.wrf_s benchmark and data files (0.3 MB)
Unpacking 623.xalancbmk_s benchmark and data files (0.1 MB)
Unpacking 625.x264_s benchmark and data files (0.2 MB)
Unpacking 627.cam4_s benchmark and data files (0.5 MB)
Unpacking 628.pop2_s benchmark and data files (283.8 MB)
Unpacking 631.deepsjeng_s benchmark and data files (0.2 MB)
Unpacking 638.imagick_s benchmark and data files (0.3 MB)
Unpacking 641.leela_s benchmark and data files (0 MB)
Unpacking 644.nab_s benchmark and data files (0.1 MB)
Unpacking 648.exchange2_s benchmark and data files (0 MB)
Unpacking 649.fotonik3d_s benchmark and data files (0.1 MB)
Unpacking 654.roms_s benchmark and data files (1.1 MB)
Unpacking 657.xz_s benchmark and data files (0.2 MB)
Unpacking 996.specrand_fs benchmark and data files (0 MB)
Unpacking 997.specrand_fr benchmark and data files (0 MB)
Unpacking 998.specrand_is benchmark and data files (0 MB)
Unpacking 999.specrand_ir benchmark and data files (6.4 MB)

Checking the integrity of your source tree...

Checksums are all okay.

Unpacking binary tools for linux-x86_64...

Checking the integrity of your binary tools...

Checksums are all okay.

Testing the tools installation (this may take a minute)

............................................................................................................................................................................................................................................................................................-.......

Installation successful.  Source the shrc or cshrc in
/home/benshan/speccpu/speccpu2017/cpu2017-1.0.5
to set up your environment for the benchmark.

benshan@public-Super-Server:/mnt/cdrom$ 
```

```bash
cp config/Example-gcc-linux-x86.cfg config/musl-gcc-linux-x86.cfg
# replace gcc_dir with /usr/local/musl in musl-gcc-linux-x86.cfg
# replace gcc with musl-gcc in musl-gcc-linux-x86.cfg
```

运行speccpu2017

```bash
cd speccpu2017/cpu2017-1.0.5
source shrc
$ runcpu --config=musl-gcc-linux-x86.cfg --action=setup --size=ref all
Build successes for fprate: 519.lbm_r(base), 538.imagick_r(base), 544.nab_r(base), 997.specrand_fr(base)
Build errors for fprate: 503.bwaves_r(base; CE), 507.cactuBSSN_r(base; CE), 508.namd_r(base; CE), 510.parest_r(base; CE), 511.povray_r(base; CE), 521.wrf_r(base; CE), 526.blender_r(base; CE), 527.cam4_r(base; CE), 549.fotonik3d_r(base; CE), 554.roms_r(base; CE)
Build successes for fpspeed: 619.lbm_s(base), 638.imagick_s(base), 644.nab_s(base), 996.specrand_fs(base)
Build errors for fpspeed: 603.bwaves_s(base; CE), 607.cactuBSSN_s(base; CE), 621.wrf_s(base; CE), 627.cam4_s(base; CE), 628.pop2_s(base; CE), 649.fotonik3d_s(base; CE), 654.roms_s(base; CE)
Build successes for intrate: 502.gcc_r(base), 505.mcf_r(base), 557.xz_r(base), 999.specrand_ir(base)
Build errors for intrate: 500.perlbench_r(base; CE), 520.omnetpp_r(base; CE), 523.xalancbmk_r(base; CE), 525.x264_r(base; CE), 531.deepsjeng_r(base; CE), 541.leela_r(base; CE), 548.exchange2_r(base; CE)
Build successes for intspeed: 602.gcc_s(base), 605.mcf_s(base), 657.xz_s(base), 998.specrand_is(base)
Build errors for intspeed: 600.perlbench_s(base; CE), 620.omnetpp_s(base; CE), 623.xalancbmk_s(base; CE), 625.x264_s(base; CE), 631.deepsjeng_s(base; CE), 641.leela_s(base; CE), 648.exchange2_s(base; CE)
```

```bash
runcpu --config=musl-gcc-linux-x86.cfg --action=run --size=ref all
```

[Install / execute spec cpu2006 benchmark](https://sjp38.github.io/post/spec_cpu2006_install/)

```bash
mkdir tmnt
sudo mount -o loop SPEC_CPU2006v1.1.iso ./tmnt
ls tmnt
```
