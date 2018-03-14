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

RUN mkdir -p $GOPATH/src/github.com/tendermint
RUN git clone https://github.com/tendermint/tendermint $GOPATH/src/github.com/tendermint/tendermint
RUN go get github.com/Masterminds/glide
RUN cd $GOPATH/src/github.com/tendermint/tendermint && git checkout tags/v0.14.0 && glide install && make install

RUN mkdir -p $GOPATH/src/github.com/tendermint
RUN git clone https://github.com/tendermint/ethermint $GOPATH/src/github.com/tendermint/ethermint
RUN cd $GOPATH/src/github.com/tendermint/ethermint && make get_vendor_deps && make install

RUN apt-get install software-properties-common && add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update && apt-get install ethereum -y

ENTRYPOINT cd node && ./start.sh && /bin/bash