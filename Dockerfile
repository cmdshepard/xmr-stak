FROM ubuntu:16.04

RUN apt-get -y update && apt-get install -y libmicrohttpd-dev vim tmux libssl-dev cmake build-essential libhwloc-dev git

WORKDIR /root/xmr-stak/

COPY . .

RUN mkdir ./build && \
  cd ./build && \
  cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF .. && \
  make install && \
  cp /root/xmr-stak/config.txt /root/xmr-stak/build/bin/config.txt && \
  sysctl -w vm.nr_hugepages=128 && \
  echo "* soft memlock 262144" >> /etc/security/limits.conf && \
  echo "* hard memlock 262144" >> /etc/security/limits.con

CMD ["/root/xmr-stak/build/bin/xmr-stak"]
