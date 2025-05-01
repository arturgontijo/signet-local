docker build -t signet-local .

docker rm -f bitcoin-signet-node

BITCOIN_DATA_DIR=$(pwd)/bitcoin-data

rm -rf $BITCOIN_DATA_DIR

docker run -dti \
  --rm \
  --name bitcoin-signet-node \
  -p 38332:38332 \
  -p 38333:38333 \
  -v $BITCOIN_DATA_DIR:/root/.bitcoin \
  -e BLOCK_TIME=5 \
  --entrypoint=bash \
  signet-local

docker cp bitcoin.conf bitcoin-signet-node:/root/bitcoin.conf

docker exec -ti bitcoin-signet-node bash -c "/run.sh"

docker logs -f bitcoin-signet-node
