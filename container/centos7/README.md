# CentOS 7 FMADIO LXC Container

Reference CentOS 7 FMADIO LXC Continer for use on FMADIO Packet Capture Systems.


## Config


The default static IP address is 192.168.1.10/24 GW:192.168.1.1 


LXC Config as follows

'''
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
'''

