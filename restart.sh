docker rm -f bitcoin-signet-node

rm -rf bitcoin-data
BITCOIN_DATA_DIR=$(pwd)/bitcoin-data

docker run -d \
  --rm \
  --name bitcoin-signet-node \
  -p 38332:38332 \
  -p 38333:38333 \
  -v $BITCOIN_DATA_DIR:/root/.bitcoin \
  -e BLOCK_TIME=10 \
  signet-local

docker logs -f bitcoin-signet-node
