FROM debian:bookworm-slim

# Set environment variable to make apt-get install non-interactive
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

ARG TARGETPLATFORM
ARG BITCOIN_VERSION  

ENV BITCOIN_VERSION=${BITCOIN_VERSION:-28.0}

RUN  apt-get update && \
     apt-get install -qq --no-install-recommends ca-certificates curl procps python3

RUN cd /tmp && \
  ARCH=$(uname -m) && \
  BITCOIN_URL="https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-${ARCH}-linux-gnu.tar.gz" && \
  BITCOIN_FILE="bitcoin-${BITCOIN_VERSION}-${ARCH}-linux-gnu.tar.gz" && \
  curl -L -o "${BITCOIN_FILE}" "${BITCOIN_URL}" && \
  mkdir -p /tmp/bin && \
  tar -xzvf "${BITCOIN_FILE}" -C /tmp/bin --strip-components=2 "bitcoin-${BITCOIN_VERSION}/bin/bitcoin-cli" "bitcoin-${BITCOIN_VERSION}/bin/bitcoind" "bitcoin-${BITCOIN_VERSION}/bin/bitcoin-wallet" "bitcoin-${BITCOIN_VERSION}/bin/bitcoin-util" 

RUN ln -s /tmp/bin/bitcoind /usr/local/bin/bitcoind
RUN ln -s /tmp/bin/bitcoin-cli /usr/local/bin/bitcoin-cli
RUN ln -s /tmp/bin/bitcoin-util /usr/local/bin/bitcoin-util

COPY mine.sh /mine.sh
COPY run.sh /run.sh
COPY miner /miner

ENV BITCOIN_DATA_DIR=$HOME/.bitcoin
RUN mkdir $BITCOIN_DATA_DIR

ENV BITCOIND=/usr/local/bin/bitcoind
ENV BITCOIN_CLI=/usr/local/bin/bitcoin-cli
ENV BITCOIN_UTIL=/usr/local/bin/bitcoin-util
ENV MINER=/miner/main.py
ENV MINING_LOOP=/mine.sh

COPY bitcoin.conf $HOME/bitcoin.conf

CMD ["bash", "-c", "/run.sh"]
