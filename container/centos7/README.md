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

By default FMADIO uses virtual ethernet bridged networking, this allows the container to be utilized as a full standalone linux system running off a different IP, even tho its running on the FMADIO hardware. Network topology is shown below


![LXC Network Topology](./images/network_topology.png)


### Host System

In the above diagram the FMADIO Packet Capture system running on as Host (baremetal) uses the virtual ethernet bridge "man0" with a static IP of 192.168.1.2/24 This interface is the general management used for FMADIO GUI, SSH etc to operate the core FMADIO Packet Capture System. 

### Container 0

In additionm the above diagram has "CentOS LXC Container 0" which is a virtualized (Using LXC) CentOS image running on the FMAD Packet Capture Hardware. It also uses the virtual ethernet bridge "man0" for connectivity and has its ethernet interface configured for 192.168.1.10/24 

### Container 1

Siliarly a 2nd "CentOS LXC Container 1" image is also running on the FMADIO Packet Capture Hardware, also using the virtual ethernet bridge "man0" with a static IP of 192.168.1.11/24 

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
lxc.rootfs.path = dir:/opt/fmadio/lxc/lib/lxc/centos7/rootfs
lxc.uts.name = centos

# Network configuration
lxc.net.0.type = veth
lxc.net.0.link = man0
lxc.net.0.flags = up
lxc.net.0.ipv4.address = 192.168.1.10
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
IPADDR=192.168.1.10
PREFIX=24
GATEWAY=192.168.1.1
DNS1=192.168.1.1
```

To change the static IP address please update both files appropriately 

