#!/bin/sh

mkdir -p /usr/share/nginx/html/test
cd /usr/share/nginx/html/test

dd if=/dev/urandom of=file-10K.dat bs=10K count=1
dd if=/dev/urandom of=file-100K.dat bs=100K count=1
dd if=/dev/urandom of=file-1M.dat bs=1M count=1
dd if=/dev/urandom of=file-10M.dat bs=10M count=1

/tmp/generate-images.py -s 1
/tmp/generate-images.py -s 10
/tmp/generate-images.py -s 100
/tmp/generate-images.py -s 1024
mv test_1024KB.jpg test_1MB.jpg

mkdir imgs
cd imgs
/tmp/generate-images.py -n 10 -s 100
