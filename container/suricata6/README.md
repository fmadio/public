# Suricata 6.0 Container

Container using Ubuntu 20 base with a stock Suricata installation. This shows how to feed PCAP data from the FMADIO Capture system into an isntance of Suricata both histoically and in realtime


# Configuration


## Network

First configuration the network using bridged networking

![LXC Network Topology](/images/network_topology.png)


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


