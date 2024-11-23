# Only one single output remains unspent from block 123,321. What address was it sent to?
block_hash=$(bitcoin-cli getblockhash 123321)
block_txs=$(bitcoin-cli getblock "$block_hash" | jq -r '.tx[]')

for tx in $block_txs; do
    raw_tx=$(bitcoin-cli getrawtransaction "$tx")
    vouts=$(bitcoin-cli decoderawtransaction "$raw_tx" | jq -c '.vout[] | {index: .n, address: .scriptPubKey.address, txid: "'"$tx"'"}')

    while IFS= read -r vout; do
        index=$(echo "$vout" | jq -r '.index')
        address=$(echo "$vout" | jq -r '.address')
        txid=$(echo "$vout" | jq -r '.txid')

        is_utxo=$(bitcoin-cli gettxout "$txid" "$index")

        if [ -n "$is_utxo" ]; then
            echo $address
            exit 0
        fi

    done <<<$vouts

done
