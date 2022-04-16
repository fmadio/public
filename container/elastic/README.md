# Elastic Grafana container

containers

- elasticsearch 7.17
- kibana 7.17
- grafana 8.4.4

default container only uses 1 CPU

## Install 

 Untar

```
 cd /opt/fmadio/lxc/
 tar xfzv elastic-YYYMMDD.tar.gz
```

 sym link

```
 ln -s elastic-YYYMMDD.tar.gz elastic
```

 run install

```
 cd elastic
 sudo ./install.lua
```

 start

```
 sudo lxc-start -n elastic
```

wait a minute for ES/Kibana/Grafana to spin up

check elastic health

```
fmadio@fmadio40v3SM-455:~$ curl http://192.168.1.100:9200/
{
  "name" : "elastic-20220329",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "Vtl7sqJBSve37X7QWqbV7w",
  "version" : {
    "number" : "7.17.1",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "e5acb99f822233d62d6444ce45a4543dc1c8059a",
    "build_date" : "2022-02-23T22:20:54.153567231Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
fmadio@fmadio40v3SM-455:~$ 
```

If theres some problem, please check amount of disk space is ok


## PCAP2JSON

Default index name "pcap2json_index"

## Changelog 


elastic-20220414.tar.gz

- added private interface 192.168.2.255.0/24 to conatiner
- installed world map grafana plugin 
- installed generic JSON source grafana plugin 
- default pcap2json_index with mapping 
- default Grafana FMADIO pcap2json dashboard 
