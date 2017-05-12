FROM fukamachi/roswell

RUN set -x && \
    apt-get install -y sbcl zlib1g libuv-dev && \
    mkdir -p /btckun && \
    ros setup && \
    ros install sbcl && \
    ros use sbcl && \
    ros install qlot && \
    echo '(setf sb-impl::*default-external-format* :utf-8)' >> $HOME/.roswell/bin/qlot
COPY . /btckun/
WORKDIR /btckun/
CMD /usr/bin/make run
