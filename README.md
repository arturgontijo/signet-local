# Signet Local Docker Container

## Build
```
docker build -t signet-local .
```

## Run (restart, reset)
This command will reset and start a net signet from genesis everytime.
```
./restart.sh
```
NOTE: Be sure to wait till block height 100+ in order to spend coinbase funds from `miner` wallet.

## Connect

You can use this as your client `bitcoin.conf`, eg:
```
txindex=1

rpcconnect=0.0.0.0:38332
rpcuser=local
rpcpassword=local

[signet]
signetchallenge=51
```
And then:
```
bitcoin-cli -signet -rpcwallet=miner getbalance
```
