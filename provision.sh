#!/bin/bash
apt-get -y update && \
  apt-get install -y libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev && \
  mkdir build/ && \
  cd build/ && \
  cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF .. && \
  make install && \
  cp ../config.txt ./bin/config.txt && \
  sysctl -w vm.nr_hugepages=128 && \
  echo "* soft memlock 262144" >> /etc/security/limits.conf && \
  echo "* hard memlock 262144" >> /etc/security/limits.con
