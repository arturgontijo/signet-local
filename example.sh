docker build -t signet-local .

export BITCOIN_DATA_DIR=$(pwd)/bitcoin-data

docker run -d \
  --rm \
  --name bitcoin-signet-node \
  -p 38332:38332 \
  -p 38333:38333 \
  -v $BITCOIN_DATA_DIR:/root/.bitcoin \
  -e BLOCK_TIME=10 \
  signet-local

bitcoin-cli -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR listwallets
bitcoin-cli -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR getbalance
bitcoin-cli -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR scantxoutset start '[{"desc":"addr(tb1q7l0fglkc2t99lg4yeg9s54a0pdnqs6rw42d3ux)"}]' | jq .total_amount

tb1q7l0fglkc2t99lg4yeg9s54a0pdnqs6rw42d3ux