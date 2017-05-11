FROM centos:7

RUN set -x && \
    mkdir -p /btckun && \
#    sudo apt-get upgrade -y && \
    yum update -y && \
    yum install -y make bzip2 bash git gcc make gcc-c++ glibc autoconf automake openssl curl-devel libuv-devel && \
    git clone -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh bootstrap && \
    ./configure && \
    make && \
    make install && \
    ros setup && \
    ros install sbcl/1.3.17 && \
    ros use sbcl/1.3.17 && \
    ros install qlot
COPY . /btckun/
WORKDIR /btckun/
CMD /bin/make run
