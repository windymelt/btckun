FROM fukamachi/roswell

RUN set -x && \
    mkdir -p /btckun && \
    echo "#+sbcl (unless (eq sb-impl::default-external-format :UTF-8)" >> /root/.sbclrc && \
    echo "(setf sb-impl::default-external-format :UTF-8))" >> /root/.sbclrc && \
    ros setup && \
    ros install sbcl && \
    ros use sbcl && \
    ros install qlot
COPY . /btckun/
WORKDIR /btckun/
CMD /usr/bin/make run
