#!/usr/local/bin/bash
curl -H "Content-Type: application/json"    -XPOST "http://192.168.255.110:9200/pcap2json_index/_search" --data-binary "@last.json" | jq

