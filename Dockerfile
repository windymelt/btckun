FROM fukamachi/roswell

RUN set -x && \
    apt-get install -y sbcl libuv-dev && \
    mkdir -p /btckun && \
    echo "#+sbcl (unless (eq sb-impl::default-external-format :UTF-8)" >> /root/.sbclrc && \
    echo "(setf sb-impl::default-external-format :UTF-8))" >> /root/.sbclrc && \
    ros setup && \
    ros install ccl-bin && \
    ros use ccl-bin && \
    ros install qlot
COPY . /btckun/
WORKDIR /btckun/
CMD /usr/bin/make run
