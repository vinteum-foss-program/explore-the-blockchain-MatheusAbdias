# Which tx in block 257,343 spends the coinbase output of block 256,128?
block_hash=$(bitcoin-cli getblockhash 256128)
coin_base_tx_id=$(bitcoin-cli getblock "$block_hash" | jq -r '.tx[0]')
block_hash=$(bitcoin-cli getblockhash 257343)
block_txs=$(bitcoin-cli getblock "$block_hash" | jq -r '.tx[]')

for tx in $block_txs; do
    raw_tx=$(bitcoin-cli getrawtransaction "$tx")
    tx_id=$(bitcoin-cli decoderawtransaction "$raw_tx" | jq --arg coin_base_tx_id "$coin_base_tx_id" '.vin[] | select(.txid == $coin_base_tx_id) | .txid')
    if [ -n "$tx_id" ]; then
        echo $tx
        break
    fi
done
