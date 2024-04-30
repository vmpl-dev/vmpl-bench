#!/bin/bash

SIZES="1 10 20 30 40 50 60 70 80 90 100"
for S in $SIZES
do
    dd if=/dev/urandom of=/var/www/html/${S}K.html count=${S}K bs=1
done