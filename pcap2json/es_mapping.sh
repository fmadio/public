#!/usr/local/bin/bash
/usr/local/bin/curl -H "Content-Type: application/json"  -XPUT "192.168.255.110:9200/pcap2json_index?pretty" --data-binary "@mapping.json" | jq 

# disable replicas
/usr/local/bin/curl -H 'Content-Type: application/json' -X PUT http://192.168.255.110:9200/_template/default -d '{"index_patterns": ["*"],"order": -1,"settings": {"number_of_shards": "1","number_of_replicas": "0"}}' | jq

