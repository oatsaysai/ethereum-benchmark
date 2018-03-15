#!/bin/bash
set -u
set -e

if [ $NODE != "" ]; then
  echo "[*] Cleaning up temporary data directories"
  rm -rf qdata
  mkdir -p qdata/logs

  echo "[*] Configuring node $NODE"
  mkdir -p qdata/dd$NODE/{keystore,geth}
  cp permissioned-nodes.json qdata/dd$NODE/static-nodes.json
  cp permissioned-nodes.json qdata/dd$NODE/
  cp keys/key$NODE qdata/dd$NODE/keystore
  cp raft/nodekey$NODE qdata/dd$NODE/geth/nodekey
  geth --datadir qdata/dd$NODE init genesis.json

  echo "[*] Starting Ethereum nodes"

  FLAGS="--datadir qdata/dd$NODE --shh --port 21000 --unlock 0 --password passwords.txt --syncmode full --mine --nodiscover"

  RPC_API="admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum"
  HTTP_RPC_ARGS="--rpc --rpcaddr 0.0.0.0 --rpcport 22000 --rpcapi $RPC_API"
  WS_RPC_ARGS="--ws --wsaddr 0.0.0.0 --wsport 23000 --wsapi $RPC_API --wsorigins=*"

  ALL_ARGS="$FLAGS $HTTP_RPC_ARGS $WS_RPC_ARGS"

  nohup geth $ALL_ARGS --targetgaslimit 50000000 &> qdata/logs/$NODE.log &

  while true; do sleep 1000; done
else
  echo "Please input NODE environment"
fi
