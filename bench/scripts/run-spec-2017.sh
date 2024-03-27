#!/bin/bash

function config()
{
    source /home/benshan/cpu2017/0-setenv-gcc.sh
    source /home/benshan/cpu2017/shrc

    path=/home/benshan/cpu2017/test-log
    filename=${1}-`date`-gcc.log
    cfg='gcc.cfg --noreportable'
}

# 可增加一些方法进行每次测试前的memory、cache等清理，
# 使得到的结果更准确
function build()
{
    config $1
    echo '****** buildstart time '`date +%Y-%m-%d-%H-%M-%S`' *****'>>${path}/${filename} cfg>&1

    runcpu -c $cfg  -a clean $1 >>${path}/${filename} 2>&1
    runcpu -c $cfg  -a clobber $1 >>${path}/${filename} 2>&1
    runcpu -c $cfg  -a build --rebuild $1>>${path}/${filename} 2>&1

    echo '****** build-end time is '`date +%Y-%m-%d-%H-%M-%S`' ******'>>${path}/${filename} cfg>&1
}

function run()
{
    echo '****** run start time '`date +%Y-%m-%d-%H-%M-%S`' *****'>>${path}/${filename} cfg>&1

    runcpu -c $cfg  -a run --nobuild -i ref -n 1  $1 >>${path}/${filename} 2>&1

    echo '****** run-end time is '`date +%Y-%m-%d-%H-%M-%S`' *****'>>${path}/${filename} cfg>&1
}

# build fprate
run fprate

# build intrate
run intrate

# build intspeed
run intspeed

# build fpspeed
run fpspeed
