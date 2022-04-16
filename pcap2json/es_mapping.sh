#!/usr/local/bin/bash
/usr/local/bin/curl -H "Content-Type: application/json"  -XPUT "192.168.255.110:9200/pcap2json_index?pretty" --data-binary "@mapping.json" | jq 
