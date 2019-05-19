#!/bin/bash

pak() {
  for i in $(ls -d */|head -n -1); do 
    echo ${i%%/};
    tar -zcf ${i%%/}.tgz ${i%%/}
    rm -rf ${i%%/}
  done
}

#cd /home/ubuntu/mevo/csv
#pak
cd /home/ubuntu/mevo/js
pak
