#!/bin/bash
set -u
set -e

if [ $NODE != "" ]; then
  echo "[*] Cleaning up temporary data directories"

  # tendermint --home qdata/dd$NODE/tendermint init
  # ethermint --datadir qdata/dd$NODE/ethermint init

  rm -rf qdata/dd$NODE
  mkdir -p qdata
  mkdir -p qdata/logs

  mkdir -p qdata/dd$NODE/ethermint/{keystore,geth,tendermint}
  cp keys/key$NODE qdata/dd$NODE/ethermint/keystore
  ethermint --datadir qdata/dd$NODE/ethermint init genesis.json
  rm -rf qdata/dd$NODE/ethermint/keystore/UTC*
  cp -r tendermint_keys/dd$NODE/tendermint qdata/dd$NODE/tendermint

  nohup tendermint --home qdata/dd$NODE/tendermint node &> qdata/logs/tendermint_$NODE.log &
  
  echo "[*] Starting Ethermint node"
  FLAGS="--rpcport 22000 --unlock 0 --password passwords.txt"
  ALL_ARGS="--datadir qdata/dd$NODE/ethermint --rpc --rpcaddr=0.0.0.0 --ws --wsaddr=0.0.0.0 --rpcapi eth,net,web3,personal,admin,txpool"
  nohup ethermint $ALL_ARGS $FLAGS &> qdata/logs/$NODE.log &

  while true; do sleep 1000; done
else
  echo "Please input NODE environment"
fi
