#!/usr/local/bin/bash
/usr/local/bin/curl -H "Content-Type: application/json"  -XDELETE "192.168.255.110:9200/pcap2json_index" | jq 

