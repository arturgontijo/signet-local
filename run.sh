rm -rf $BITCOIN_DATA_DIR
mkdir $BITCOIN_DATA_DIR

cp $HOME/bitcoin.conf $BITCOIN_DATA_DIR/bitcoin.conf

$BITCOIND -signet -datadir=$BITCOIN_DATA_DIR -fallbackfee=0.01 -daemonwait -persistmempool
$BITCOIN_CLI -signet -datadir=$BITCOIN_DATA_DIR createwallet miner

$MINING_LOOP
