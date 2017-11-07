FROM python:3

ENV VERSION 3.0

RUN curl -o /tmp/Electrum-${VERSION}.tar.gz https://download.electrum.org/${VERSION}/Electrum-${VERSION}.tar.gz \
  && curl -o /tmp/Electrum-${VERSION}.tar.gz.asc https://download.electrum.org/${VERSION}/Electrum-${VERSION}.tar.gz.asc

RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 0x2bd5824b7f9470e6 \
  && gpg --list-keys '0x6694D8DE7BE8EE5631BED9502BD5824B7F9470E6' \
  && gpg --verify /tmp/Electrum-${VERSION}.tar.gz.asc /tmp/Electrum-${VERSION}.tar.gz

RUN pip install /tmp/Electrum-${VERSION}.tar.gz

RUN useradd -d /home/user -m user \
  && mkdir /electrum \
  && ln -s /electrum /home/user/.electrum \
  && chown user:user /electrum

USER user
ENV HOME /home/user
WORKDIR /home/user
VOLUME /electrum

CMD ["/bin/bash", "-i", "-c", "/usr/local/bin/electrum daemon start --proxy socks5:torsock:9050 -s 4cii7ryno5j3axe4.onion:50001:t"]
