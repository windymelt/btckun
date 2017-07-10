FROM debian:jessie

RUN set -x && \
    apt-get update && apt-get install -y git build-essential automake libcurl4-openssl-dev zlibc zlib1g zlib1g-dev libuv-dev && \
    git clone -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    ros setup && \
    cd ~/ && \
    mkdir -p /btckun && \
    ros install sbcl/1.3.19 && \
    ros use sbcl/1.3.19 && \
    ros install qlot && \
    echo '(setf sb-impl::*default-external-format* :utf-8)' >> $HOME/.roswell/bin/qlot
COPY . /btckun/
WORKDIR /btckun/
CMD /usr/bin/make run
