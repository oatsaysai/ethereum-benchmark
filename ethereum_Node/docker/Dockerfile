FROM ubuntu

RUN apt-get update &&  apt-get install -y
RUN apt-get install -y software-properties-common python-software-properties wget git psmisc build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev sysvbanner wrk

ENV GOREL=go1.9.3.linux-amd64.tar.gz
RUN wget -q https://storage.googleapis.com/golang/$GOREL && tar xfz $GOREL
RUN mv go /usr/local/go && rm -f $GOREL
RUN mkdir /usr/local/path

ENV PATH=$PATH:/usr/local/go/bin
ENV GOROOT=/usr/local/go
ENV GOPATH=/usr/local/path
ENV GOBIN=/usr/local/go/bin

RUN git clone https://github.com/ethereum/go-ethereum.git
RUN cd go-ethereum && git checkout tags/v1.8.2 && make all && cp build/bin/geth /usr/local/bin && cp build/bin/bootnode /usr/local/bin

ENTRYPOINT cd node && ./start.sh && /bin/bash