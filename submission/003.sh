# How many new outputs were created by block 123,456?
bicoin-cli getblockstats 123456 | jq ."outs?"
