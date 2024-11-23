# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
raw_tx=$(bitcoin-cli getrawtransaction "e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163")
witness_script=$(bitcoin-cli decoderawtransaction "$raw_tx" | jq -r '.vin[0].txinwitness[-1]')
pub_key=$(echo $witness_script | cut -c 5-70)
echo $pub_key
