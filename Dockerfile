FROM ubuntu:14.04

RUN set -x && \
    mkdir -p /btckun && \
    sudo apt-get update -y && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y omake git build-essential automake libcurl4-openssl-dev && \
    git clone -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh bootstrap && \
    ./configure && \
    make && \
    sudo make install && \
    ros setup && \
    ros install sbcl/1.3.17 && \
    ros use sbcl/1.3.17 && \
    ros install qlot
COPY . /btckun/
WORKDIR /btckun/
CMD /usr/bin/omake run
