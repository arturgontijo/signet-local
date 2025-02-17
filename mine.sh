#!/bin/bash
NBITS=${NBITS:-"1e0377ae"}
BLOCK_TIME=${BLOCK_TIME:="60"}

# Genesis
PUBKEY=${MINETO:-$($BITCOIN_CLI -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR getnewaddress)}
$MINER --cli="$BITCOIN_CLI -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR" generate --grind-cmd="$BITCOIN_UTIL grind" --address=$PUBKEY --nbits=$NBITS --set-block-time=$(date +%s)
sleep 1

# Mine 100 blocks (coinbase funds are confirmed after 100 blocks)
for ((i=1; i<=100; i++))
do
  $MINER --cli="$BITCOIN_CLI -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR" generate --grind-cmd="$BITCOIN_UTIL grind" --address=$PUBKEY --nbits=$NBITS --set-block-time=$(date +%s)
  sleep 0.1
done

while true; do
    ADDR=${MINETO:-$($BITCOIN_CLI -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR getnewaddress)}
    $MINER --cli="$BITCOIN_CLI -signet -rpcwallet=miner -datadir=$BITCOIN_DATA_DIR" generate --grind-cmd="$BITCOIN_UTIL grind" --address=$ADDR --nbits=$NBITS --set-block-time=$(date +%s)
    sleep $BLOCK_TIME
done
