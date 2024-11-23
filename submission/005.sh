# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

raw_tx=$(bitcoin-cli getrawtransaction "37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517")
decoded_tx=$(bitcoin-cli decoderawtransaction "$raw_tx")
witness_pub_keys=$(echo "$decoded_tx" | jq -r '[.vin[].txinwitness[-1]] | join(",")')
bitcoin-cli createmultisig 1 "[\"$(echo $witness_pub_keys | sed 's/,/\",\"/g')\"]" | jq -r '.address'
