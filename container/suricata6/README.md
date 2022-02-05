# Suricata 6.0 Container

Container using Ubuntu 20 base with a stock Suricata 6.0.4 installation. This shows how to feed PCAP data from the FMADIO Capture system into an isntance of Suricata both histoically and in realtime


# Configuration


## Network

First configuration the network using bridged networking

![LXC Network Topology](/images/network_topology.png)


### Host System

In the above diagram the FMADIO Packet Capture system running on as Host (baremetal) uses the virtual ethernet bridge "man0" with a static IP of 192.168.1.10/24 This interface is the general management used for FMADIO GUI, SSH etc to operate the core FMADIO Packet Capture System. 

### Container 0

In additionm the above diagram has "Link LXC Container 0" which is a virtualized (Using LXC) Linux image running on the FMAD Packet Capture Hardware. It also uses the virtual ethernet bridge "man0" for connectivity and has its ethernet interface configured for 192.168.1.11/24 

### Container 1

Siliarly a 2nd "Linux LXC Container 1" image is also running on the FMADIO Packet Capture Hardware, also using the virtual ethernet bridge "man0" with a static IP of 192.168.1.12/24 

### Topology 

All these interfaces utilize the "man0" virtual ethernet bridge, meaning while they share the same physical network interface "phy0" they all have unique and seperate IP addresse on the 192.168.1.0/24 network. From an external server it appears they are 3 seperate systems.

While this example usses "man0" with physical network interface "phy0" a 1G RJ45 socket. This can be applied to the 10G/40G physical network interfaces "phy10" and "phy11" for higher management interface bandwidth.


## Files 

The FMADIO Host interface is configured using

```
/opt/fmadio/etc/network.lua
```
For details see our user documentation [docs.fmad.io](https://docs.fmad.io/fmadio-documentation/configuration/network-configuration-cli)

The containers network configuration by default is the static IP address is 192.168.1.10/24 Gateway 192.168.1.1 

LXC Config is located in

```
/opt/fmadio/lxc/suricata6/config
```

Default config is as follows

```
# Distribution configuration
lxc.include = /usr/share/lxc/config/ubuntu.common.conf
lxc.arch = x86_64

# Container specific configuration
lxc.rootfs.path = dir:/opt/fmadio/lxc/suricata_6/rootfs
lxc.uts.name = suricata_6

# Network configuration
lxc.net.0.type = veth
lxc.net.0.link = man0
lxc.net.0.flags = up
lxc.net.0.ipv4.address = 192.168.1.11
lxc.net.0.ipv4.gateway = 192.168.1.1

# map passthru queue 
lxc.mount.entry = /opt/fmadio/queue/lxc_ring0 opt/fmadio/queue/lxc_ring0 none bind,create=file 0 0  
```

In addition the Ubuntu 20 network configuration file is located in


```
/opt/fmadio/lxc/suricata_6/rootfs/etc/netplan/10-lxc.yaml
```

Default configuration is as follows

```
/mnt/store0/lxc/lib/lxc/suricata_6# cat rootfs/etc/netplan/10-lxc.yaml
network:
  version: 2
    ethernets:
	  eth0:
	    dhcp4: false
	      addresses: [192.168.1.11/24]
		  gateway4: 192.168.1.1
		  nameservers:
		  addresses: [192.168.1.1]

```

To change the static IP address please update both files appropriately 

# Operation

FMADIO Runs Suricata using the PCAP interface using STDIN as the transport mode. We chose this route as it is lossless and provides a full backpressure / flow control using linux pipes and is reasonably performant. Scaling the throughput is provided using multiple LXC containers and RSS load balancing what data gets sent to each LXC container.  

![Suricata DataFlow ](/images/fmadio_lxc_suricata.png)

The primary benefit of this approach is the Suricata processing is fully lossless as it uses the FMADIO massive storage capacity as a FIFO ring buffer. This enables Suricata to process data as fast or as slow leaving the hard realtime packet capture problems to the FMADIO system.

## Container

In the container start Suricata as follows using the fmadio2pcap utility  

```
$ sudo /opt/fmadio/platform/fmadio2pcap/fmadio2pcap -i /opt/fmadio/queue/lxc_ring0  | sudo suricata -r /dev/stdin
```

Example output as follows, typically we run it in /mnt/suricata directory or a more fully enumerated path. This is so each days worth of suricata logs can be easily accessed. 


```
ubuntu@suricata6:/mnt/suricata$ sudo /opt/fmadio/platform/fmadio2pcap/fmadio2pcap -i /opt/fmadio/queue/lxc_ring0  | sudo suricata -r /dev/stdin
fmadio2pcap
FMAD Ring [/opt/fmadio/queue/lxc_ring0]
Ring size   : 10489868 10489868 16777216
Ring Version:      100      100
RING: Put:15fa3884 84
RING: Get:15fa3884 84
5/2/2022 -- 08:08:08 - <Notice> - This is Suricata version 6.0.4 RELEASE running in USER mode
5/2/2022 -- 08:08:37 - <Notice> - all 49 packet processing threads, 4 management threads initialized, engine started.

```


## FMADIO Host 

On the FMADIO Host can pipe an fmadio capture as follows 

```
sudo stream_cat -v <full capture name to replay> --ring /opt/fmadio/queue/lxc_ring1
```

Example output as follows


```
fmadio@fmadio20v3-287:$ sudo stream_cat -v <full capture name to replay> --ring /opt/fmadio/queue/lxc_ring0
outputting to FMAD Ring [/opt/fmadio/queue/lxc_ring0j
Ring size   : 10489868 16777216
Ring Version:      100      100
RING: Put:5638
RING: Get:5638
0M Offset:    0GB ChunkID:65417929 TS:00:00:14.506.442.653 | Pending  10665 MB 1.007Gbps 0.414Mpps CPUIdle:0.000 CPUFetch:0.137 CPUSend:0.000
1M Offset:    1GB ChunkID:65423026 TS:01:02:05.528.618.296 | Pending   9391 MB 10.550Gbps 1.068Mpps CPUIdle:0.000 CPUFetch:0.174 CPUSend:0.000
2M Offset:    2GB ChunkID:65428016 TS:01:53:07.401.746.274 | Pending   8144 MB 10.332Gbps 1.038Mpps CPUIdle:0.000 CPUFetch:0.150 CPUSend:0.000
3M Offset:    3GB ChunkID:65433020 TS:02:23:40.771.210.710 | Pending   6892 MB 10.365Gbps 0.990Mpps CPUIdle:0.000 CPUFetch:0.155 CPUSend:0.000
4M Offset:    4GB ChunkID:65437915 TS:03:00:17.830.519.599 | Pending   5669 MB 10.110Gbps 1.086Mpps CPUIdle:0.000 CPUFetch:0.288 CPUSend:0.000
.
.
.
.
```

## Suircata Config 

Suricata and Suricata-update config files are locateds in the default directory 

```
/etc/suricata
/var/lib/suricata/rules/
```

These can be tuned and modified based on requirements, by default logs are written in the directory suricata is run on. 

Example logfile output

```
ubuntu@suricata6:/mnt/suricata$ ls -alh
total 44M
drwxr-xr-x 2 ubuntu root 4.0K Feb  5 08:22 .
drwxr-xr-x 3 root   root 4.0K Feb  5 07:31 ..
-rw-r--r-- 1 root   root  44M Feb  5 08:25 eve.json
-rw-r--r-- 1 root   root 4.2K Feb  5 08:24 fast.log
-rw-r--r-- 1 root   root  36K Feb  5 08:24 http.log
-rw-r--r-- 1 root   root 104K Feb  5 08:25 stats.log
-rw-r--r-- 1 root   root 7.6K Feb  5 08:25 suricata.log
-rw-r--r-- 1 root   root  73K Feb  5 08:24 tls.log
ubuntu@suricata6:/mnt/suricata$
```



# Performance 


Thoughput testing TBD... working on it.

Our goal is sustained thoughput is 40Gbps per 96CPU / 576GB RAM 1U system with a reasonable Suricata ruleset (e.g ET Pro)
