# CentOS 7 FMADIO LXC Container

Reference CentOS 7 FMADIO LXC Continer for use on FMADIO Packet Capture Systems.

The image has a minimial  setup of
- GCC / build essentials
- basic networking tools
- fmadio platform checkout (https://github.com/fmadio/platform)

# Install 

Download/Checkout the LXC Image file onto the FMADIO Packet Capture host system.

Extract the contents of the tarball "fmadio_lxc_centos7.9.tar.gz"

Into /opt/fmadio/lxc/ running as sudo or root, example below 


```
root@fmadioMAG-290:/# cd /opt/fmadio/lxc/
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc#
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc# tar xfzv /mnt/store0/git/public/container/centos7/fmadio_lxc_centos7.9.tar.gz
centos7/
centos7/config
centos7/rootfs/
centos7/rootfs/sbin
centos7/rootfs/tmp/
centos7/rootfs/tmp/.font-unix/
centos7/rootfs/tmp/.X11-unix/
centos7/rootfs/tmp/.ICE-unix/
centos7/rootfs/tmp/.Test-unix/
centos7/rootfs/tmp/.XIM-unix/
centos7/rootfs/srv/
centos7/rootfs/var/
centos7/rootfs/var/.updated
centos7/rootfs/var/tmp/
centos7/rootfs/var/gopher/
centos7/rootfs/var/mail
centos7/rootfs/var/db/
centos7/rootfs/var/db/Makefile
centos7/rootfs/var/db/sudo/
centos7/rootfs/var/db/sudo/lectured/
centos7/rootfs/var/db/sudo/lectured/fmadio
centos7/rootfs/var/empty/
centos7/rootfs/var/empty/sshd/
centos7/rootfs/var/cache/
centos7/rootfs/var/cache/ldconfig/
centos7/rootfs/var/cache/ldconfig/aux-cache
centos7/rootfs/var/cache/yum/
centos7/rootfs/var/cache/yum/x86_64/
centos7/rootfs/var/cache/yum/x86_64/7/
centos7/rootfs/var/cache/yum/x86_64/7/timedhosts.txt
centos7/rootfs/var/cache/yum/x86_64/7/timedhosts
centos7/rootfs/var/cache/yum/x86_64/7/.gpgkeyschecked.yum
centos7/rootfs/var/cache/yum/x86_64/7/extras/
centos7/rootfs/var/cache/yum/x86_64/7/extras/mirrorlist.txt
centos7/rootfs/var/cache/yum/x86_64/7/extras/gen/
centos7/rootfs/var/cache/yum/x86_64/7/extras/gen/primary_db.sqlite
centos7/rootfs/var/cache/yum/x86_64/7/extras/cachecookie
centos7/rootfs/var/cache/yum/x86_64/7/extras/db1c88508275ffebdc6cd8686da08745d2552e5b219b2e6f4cbde7b8afd3b1a3-primary.sqlite.bz2
centos7/rootfs/var/cache/yum/x86_64/7/extras/repomd.xml
centos7/rootfs/var/cache/yum/x86_64/7/extras/packages/
centos7/rootfs/var/cache/yum/x86_64/7/updates/
centos7/rootfs/var/cache/yum/x86_64/7/updates/mirrorlist.txt
centos7/rootfs/var/cache/yum/x86_64/7/updates/gen/
centos7/rootfs/var/cache/yum/x86_64/7/updates/gen/primary_db.sqlite
centos7/rootfs/var/cache/yum/x86_64/7/updates/cachecook
.
.
.
.
.
.
centos7/rootfs/usr/bin/glib-compile-schemas
centos7/rootfs/selinux/
centos7/rootfs/selinux/enforce
centos7/rootfs/run/
centos7/rootfs/run/blkid/
centos7/rootfs/.autorelabel
centos7/rootfs/proc/
centos7/rootfs/bin
centos7/rootfs/mnt/
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc#
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc#
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc#
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc# ls -al centos7/
total 16
drwxrwx---    3 root     root          4096 Jan 30 11:47 .
drwxr-xr-x    6 root     root          4096 Jan 30 13:21 ..
-rw-r--r--    1 root     root           856 Jan 30 11:47 config
drwxr-xr-x   18 root     root          4096 Jan 16 16:00 rootfs
root@fmadioMAG-290:/mnt/store0/lxc/lib/lxc#
```


# Networking 

By default FMADIO uses virtual ethernet bridged networking, this allows the container to be utilized as a full standalone linux system running off a different IP, even tho its running in paralel and simultaniously on the FMADIO Packet Capture hardware. Network topology is shown below


![LXC Network Topology](./images/network_topology.png)


### Host System

In the above diagram the FMADIO Packet Capture system running on as Host (baremetal) uses the virtual ethernet bridge "man0" with a static IP of 192.168.1.10/24 This interface is the general management used for FMADIO GUI, SSH etc to operate the core FMADIO Packet Capture System. 

### Container 0

In additionm the above diagram has "CentOS LXC Container 0" which is a virtualized (Using LXC) CentOS image running on the FMAD Packet Capture Hardware. It also uses the virtual ethernet bridge "man0" for connectivity and has its ethernet interface configured for 192.168.1.11/24 

### Container 1

Siliarly a 2nd "CentOS LXC Container 1" image is also running on the FMADIO Packet Capture Hardware, also using the virtual ethernet bridge "man0" with a static IP of 192.168.1.12/24 

### Topology 

All these interfaces utilize the "man0" virtual ethernet bridge, meaning while they share the same physical network interface "phy0" they all have unique and seperate IP addresse on the 192.168.1.0/24 network. From an external server it appears they are 3 seperate systems.

While this example usses "man0" with physical network interface "phy0" a 1G RJ45 socket. This can be applied to the 10G/40G physical network interfaces "phy10" and "phy11" for higher management interface bandwidth.


## Config

The FMADIO Host interface is configured using

```
/opt/fmadio/etc/network.lua
```
For details see our user documentation [docs.fmad.io](https://docs.fmad.io/fmadio-documentation/configuration/network-configuration-cli)

The containers network configuration by default is the static IP address is 192.168.1.10/24 Gateway 192.168.1.1 

LXC Config is located in

```
/opt/fmadio/lxc/centos7/config
```

Default config is as follows

```
# Distribution configuration
lxc.include = /usr/share/lxc/config/centos.common.conf
lxc.arch = x86_64

# Container specific configuration
lxc.rootfs.path = dir:/opt/fmadio/lxc/centos7/rootfs
lxc.uts.name = centos7

# Network configuration
lxc.net.0.type = veth
lxc.net.0.link = man0
lxc.net.0.flags = up
lxc.net.0.ipv4.address = 192.168.1.11
lxc.net.0.ipv4.gateway = 192.168.1.1

# map passthru queue 
lxc.mount.entry = /opt/fmadio/queue/lxc_ring0 opt/fmadio/queue/lxc_ring0 none bind,create=file 0 0  
```

In addition the CentOS 7 network configuration file is located in


```
/opt/fmadio/lxc/centos7/rootfs/etc/sysconfig/network-scripts/ifcfg-eth0
```

Default configuration is as follows

```
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
HOSTNAME=centos
NM_CONTROLLED=no
TYPE=Ethernet
MTU=
IPADDR=192.168.1.11
PREFIX=24
GATEWAY=192.168.1.1
DNS1=192.168.1.1
```

To change the static IP address please update both files appropriately 


# Running

Booting the container use the following command

```
sudo lxc-start -n centos7
```

then attach to the console as follows 

```
sudo lxc-attach -n centos7
```

This will drop to a shell allowing further configuration and customization.

Example shown below


```
root@fmadioMAG-290:# lxc-start -n centos7

root@fmadioMAG-290:# lxc-attach -n centos7

root@centos7:/# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.2.206  netmask 255.255.255.0  broadcast 192.168.2.255
        inet6 fe80::f05a:98ff:fe56:9928  prefixlen 64  scopeid 0x20<link>
        ether f2:5a:98:56:99:28  txqueuelen 1000  (Ethernet)
        RX packets 48  bytes 15088 (14.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13  bytes 916 (916.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@centos7:/#
```

# Container Packet Capture 

The CentOS image has a version of the FMADIO Platform installed, its recommened to get the latest version using GIT.


```
root@centos7:~# cd /opt/fmadio/platform/
root@centos7:/opt/fmadio/platform# git pull
Already up-to-date.
root@centos7:/opt/fmadio/platform#

```

Packets can then be captured using the tool "fmadio2pcap" which is fully opensource, this utility is used as a minimial code example on how to receive and process packets within a container. 

Full code is here [https://github.com/fmadio/platform/blob/main/fmadio2pcap/main.c](https://github.com/fmadio/platform/blob/main/fmadio2pcap/main.c)


## Process Historical Capture


**Execute FMADIO Host**

First step is to start the FMADIO Packet Capture Tx Path. This has full flow control ensuring there are Zero Packet drops. On the host system find the capture file to send to the container and run


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


**Execute Container**

On the container, run the command in the /opt/fmadio/platform/fmadio2pcap directory to start the Rx Path

```
sudo ./fmadio2pcap -i /opt/fmadio/queue/lxc_ring0  | tcpdump  -r - -nn | head -n 100
```

Example output as below


```
[fmadio@centos7 fmadio2pcap]$ cd /opt/fmadio/platform/fmadio2pcap 
[fmadio@centos7 fmadio2pcap]$ sudo ./fmadio2pcap -i /opt/fmadio/queue/lxc_ring0  | tcpdump  -r - -nn | head -n 100
fmadio2pcap
FMAD Ring [/opt/fmadio/queue/lxc_ring0]
Ring size   : 10489868 10489868 16777216
Ring Version:      100      100
RING: Put:4d93
RING: Get:4d93
reading from file -, link-type EN10MB (Ethernet)
00:11:08.562510 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 2377520938:2377522386, ack 3714236327, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562523 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 1448:2896, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562529 IP 192.168.2.205.30464 > 192.168.2.65.46666: Flags [.], ack 4294944128, win 10578, options [nop,nop,TS val 3394241810 ecr 3075767777], length 0
00:11:08.562535 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 2896:4344, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562547 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 4344:5792, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562559 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 5792:7240, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562572 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 7240:8688, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562584 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 8688:10136, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562596 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 10136:11584, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562609 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 11584:13032, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562621 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 13032:14480, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562633 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 14480:15928, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562646 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 15928:17376, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562652 IP 192.168.2.205.30464 > 192.168.2.65.46666: Flags [.], ack 4294948472, win 10594, options [nop,nop,TS val 3394241811 ecr 3075767777], length 0
00:11:08.562658 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 17376:18824, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562670 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 18824:20272, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562674 IP 192.168.2.205.30464 > 192.168.2.65.46666: Flags [.], ack 4294958608, win 10594, options [nop,nop,TS val 3394241811 ecr 3075767777], length 0
00:11:08.562683 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 20272:21720, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562695 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 21720:23168, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562707 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 23168:24616, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562719 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 24616:26064, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562732 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 26064:27512, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562744 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 27512:28960, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562756 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 28960:30408, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562768 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 30408:31856, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562781 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 31856:33304, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562793 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 33304:34752, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562799 IP 192.168.2.205.30464 > 192.168.2.65.46666: Flags [.], ack 5792, win 10594, options [nop,nop,TS val 3394241811 ecr 3075767777], length 0
00:11:08.562806 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 34752:36200, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562818 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 36200:37648, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562830 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 37648:39096, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562843 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 39096:40544, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562855 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 40544:41992, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562867 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 41992:43440, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562879 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 43440:44888, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562892 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 44888:46336, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
00:11:08.562904 IP 192.168.2.65.46666 > 192.168.2.205.30464: Flags [.], seq 46336:47784, ack 1, win 229, options [nop,nop,TS val 3075767777 ecr 3394241810], length 1448
.
.
.
.
```
We use tcpdump for example purposes, the utlity fmadio2pcap outputs a standard PCAP with Nanosecond timestamps. Any application that uses this format will work 


## Process Live Capture 

Recommend using a 1sec flush period to ensure data gets delivered at a regular interval. Otherwise the frequency of when data is seen depends on the link activity. 

(Setting 1sec flush interval)[https://docs.fmad.io/fmadio-documentation/configuration/capture-pipeline-flush#flushperiod]

Example setting (/opt/fmadio/etc/time.lua)

```
["Capture"] =
{
	["FlushPktCnt"] = 2000,
	["FlushPeriod"] = 1e9,
	["FlushIdle"]   = 0,
},

```

Start the packet capture system


**Execute FMADIO Host**


```
fmadio@fmadio20v3-287:$ sudo stream_cat -v --follow --ring /opt/fmadio/queue/lxc_ring0
stream_cat: follow mode
outputting to FMAD Ring [/opt/fmadio/queue/lxc_ring0j
Ring size   : 10489868 16777216
Ring Version:      100      100
RING: Put:942d96
RING: Get:942d96
0M Offset:    0GB ChunkID:65468565 TS:00:00:00.000.000.000 | Pending     21 MB 0.000Gbps 0.000Mpps CPUIdle:0.000 CPUFetch:0.787 CPUSend:0.000
0M Offset:    0GB ChunkID:65468631 TS:00:00:00.000.000.000 | Pending      8 MB 0.022Gbps 0.003Mpps CPUIdle:0.981 CPUFetch:0.006 CPUSend:0.000
0M Offset:    0GB ChunkID:65468637 TS:09:58:01.151.885.306 | Pending      8 MB 0.008Gbps 0.001Mpps CPUIdle:0.998 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65468645 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65468660 TS:09:58:04.680.546.967 | Pending      8 MB 0.007Gbps 0.001Mpps CPUIdle:0.998 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65468683 TS:09:58:09.057.469.788 | Pending     10 MB 0.015Gbps 0.002Mpps CPUIdle:0.997 CPUFetch:0.001 CPUSend:0.000
0M Offset:    0GB ChunkID:65468710 TS:09:58:10.382.692.610 | Pending      8 MB 0.040Gbps 0.004Mpps CPUIdle:0.995 CPUFetch:0.002 CPUSend:0.000
0M Offset:    0GB ChunkID:65468716 TS:09:58:10.393.894.920 | Pending      8 MB 0.012Gbps 0.001Mpps CPUIdle:0.998 CPUFetch:0.000 CPUSend:0.000
.
.
.
.

```

**Execute Container**


```
[fmadio@centos7 fmadio2pcap]$ cd /opt/fmadio/platform/fmadio2pcap 
[fmadio@centos7 fmadio2pcap]$ sudo ./fmadio2pcap -i /opt/fmadio/queue/lxc_ring0  | tcpdump  -r - -nn  | head
fmadio2pcap
FMAD Ring [/opt/fmadio/queue/lxc_ring0]
Ring size   : 10489868 10489868 16777216
Ring Version:      100      100
RING: Put:953f66
RING: Get:953f66
reading from file -, link-type EN10MB (Ethernet)
09:59:36.377127 IP 192.168.2.130 > 192.168.2.125: ICMP echo request, id 3256, seq 5820, length 64
09:59:36.377157 IP 192.168.2.125 > 192.168.2.130: ICMP echo reply, id 3256, seq 5820, length 64
09:59:36.378684 IP 210.193.124.58.991 > 124.120.36.246.22599: Flags [.], seq 1452:2904, ack 1, win 1783, length 1452
09:59:36.378697 IP 210.193.124.58.991 > 124.120.36.246.22599: Flags [.], seq 2904:4356, ack 1, win 1783, length 1452
09:59:36.378709 IP 210.193.124.58.991 > 124.120.36.246.22599: Flags [.], seq 4356:5808, ack 1, win 1783, length 1452
09:59:36.378721 IP 210.193.124.58.991 > 124.120.36.246.22599: Flags [.], seq 5808:7260, ack 1, win 1783, length 1452
.
.
.
.
```

The data will ebb and flow based on the traffic volume. The processing is always fully lossless and based on how fast the Container software can recevied/process the data. Tcpdump is pretty slow so the thoughput wont be too high. 


## Process Filtered Live Capture 


In addition to Live data capture, filtering of the data before it gets sent to the Container is possible using standard BPF filters. The following example output sends ARP requests to the container.

**Execute FMADIO Host**

```
fmadio@fmadio20v3-287:$ sudo stream_cat -v --follow --ring /opt/fmadio/queue/lxc_ring0  --bpf "arp"
stream_cat: follow mode
outputting to FMAD Ring [/opt/fmadio/queue/lxc_ring0j
BPF Filter [arp]
stream_cat ioqueue: 4
Using Filename [asdf_20220130_0957]
calibrating...
0 : 2095077860           2.0951 cycles/nsec offset:4.922 Mhz
Cycles/Sec 2095077860.0000 Std:       0 cycle std(  0.00000000) Target:2.10 Ghz
StartChunkID: 65470683
StartChunk: 65470683 Offset: 0 Stride: 1
StartChunk: 65470683
Ring size   : 10489868 16777216
Ring Version:      100      100
RING: Put:954430
RING: Get:954430
0M Offset:    0GB ChunkID:65470683 TS:00:00:00.000.000.000 | Pending     21 MB 0.000Gbps 0.000Mpps CPUIdle:0.000 CPUFetch:0.764 CPUSend:0.000
0M Offset:    0GB ChunkID:65470741 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.996 CPUFetch:0.002 CPUSend:0.000
0M Offset:    0GB ChunkID:65470748 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.998 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470752 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470757 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470761 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470766 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470772 TS:10:04:37.644.451.695 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.998 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470777 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
0M Offset:    0GB ChunkID:65470781 TS:00:00:00.000.000.000 | Pending      8 MB 0.000Gbps 0.000Mpps CPUIdle:0.999 CPUFetch:0.000 CPUSend:0.000
.
.
.
.
.
```

**Execute Container**

```
[fmadio@centos7 fmadio2pcap]$ cd /opt/fmadio/platform/fmadio2pcap 
[fmadio@centos7 fmadio2pcap]$ sudo ./fmadio2pcap -i /opt/fmadio/queue/lxc_ring0  | tcpdump  -r - -nn
fmadio2pcap
FMAD Ring [/opt/fmadio/queue/lxc_ring0]
Ring size   : 10489868 10489868 16777216
Ring Version:      100      100
RING: Put:9543f0
RING: Get:9543f0
reading from file -, link-type EN10MB (Ethernet)
10:03:05.468490 ARP, Request who-has 192.168.2.130 tell 192.168.2.73, length 50
10:03:05.468558 ARP, Reply 192.168.2.130 is-at 00:16:3e:bc:a1:6f, length 50
10:03:08.380996 ARP, Request who-has 192.168.2.130 tell 192.168.2.125, length 50
10:03:08.381030 ARP, Reply 192.168.2.130 is-at 00:16:3e:bc:a1:6f, length 50
10:03:11.860161 ARP, Request who-has 192.168.2.65 tell 192.168.2.130, length 50
10:03:11.860189 ARP, Reply 192.168.2.65 is-at 30:9c:23:df:f0:5f, length 50
10:03:12.548218 ARP, Request who-has 192.168.2.223 tell 192.168.2.130, length 50
10:03:12.548381 ARP, Reply 192.168.2.223 is-at 18:c0:4d:b4:0e:72, length 50
10:03:16.337276 ARP, Request who-has 192.168.2.65 tell 192.168.2.205, length 50
10:03:16.337313 ARP, Reply 192.168.2.65 is-at 30:9c:23:df:f0:5f, length 50
10:03:21.492033 ARP, Request who-has 192.168.2.73 tell 192.168.2.130, length 50
10:03:21.492146 ARP, Reply 192.168.2.73 is-at 00:25:90:fe:91:9c, length 50
10:03:21.935424 ARP, Reply 192.168.2.185 is-at b4:2e:99:25:09:f9, length 50
10:03:23.203941 ARP, Request who-has 192.168.2.205 tell 192.168.2.131, length 50
.
.
.
.
.
.
```


