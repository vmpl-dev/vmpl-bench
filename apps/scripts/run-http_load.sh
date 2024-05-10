#!/bin/bash

# run ./http_load with the given number of requests

pushd http_load-09Mar2016

for size in {1,10,20,30,40,50,60,70,80,90,100}
do
    echo http://localhost:8004/${size}K.html > ./url_file
    ./http_load -parallel 10 -fetches 1000 -verbose ./url_file
done

popd