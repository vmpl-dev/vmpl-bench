
# SPEC CPU Benchmark

## SPEC CPU 2006

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
cd ~/speccpu/speccpu2017
mount cpu2017-1.0.5.iso /mnt/cdrom -o uid=1001,gid=1001
cd /mnt/cdrom
./install.sh
```

运行speccpu2017

```bash
cd speccpu2017
source shrc
runcpu --config=aarch64 --action=setup --size=ref all
```

[Install / execute spec cpu2006 benchmark](https://sjp38.github.io/post/spec_cpu2006_install/)

```bash
mkdir tmnt
sudo mount -o loop SPEC_CPU2006v1.1.iso ./tmnt
ls tmnt
```
