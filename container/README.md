# FMADIO Public Containers

Reference LXC containers used for demonstration purposes 

# Install


### STEP 1

Enable Containers in the configuration file

Edit the file:

```
/opt/fmadio/etc/time.lua
```

In the section titled ["Container"] set Enable = true as follows

```
,
["Container"] =
{
	["Enable"]     	= true,
}
```

Then run the following to ensure the configuration file is correctly formatted 

```
fmadiolua /opt/fmadio/etc/time.lua
```

Correct output looks like the following


```
fmadio@fmadio100v2-228U:~$ fmadiolua /opt/fmadio/etc/time.lua
fmad fmadlua Feb 25 2022
loading filename [/opt/fmadio/etc/time.lua]
done 0.000145Sec 0.000002Min
fmadio@fmadio100v2-228U:~$
```

### STEP 2

Reboot the system. This will create any LXC specific directories on reboot 


### STEP 4

Checkout this Repo with LFS data 

```
cd /mnt/store0/
git clone https://github.com/fmadio/public.git
```

Example as follows.

```
fmadio@fmadio100v2-228U:/mnt/store0/tmp2$ git clone https://github.com/fmadio/public.git
Cloning into 'public'...
remote: Enumerating objects: 243, done.
remote: Counting objects: 100% (228/228), done.
remote: Compressing objects: 100% (153/153), done.
remote: Total 243 (delta 83), reused 183 (delta 38), pack-reused 15
Receiving objects: 100% (243/243), 264.16 KiB | 11.49 MiB/s, done.
Resolving deltas: 100% (86/86), done.
Filtering content: 100% (2/2), 609.50 MiB | 10.85 MiB/s, done.

fmadio@fmadio100v2-228U:/mnt/store0/tmp2$ 
```


### STEP 3

LXC containers are located in the directory 

```
/opt/fmadio/lxc/

```
extract the tarball into the above directory

Example:

```
fmadio@fmadio100v2-228U:$ cd /opt/fmadio/lxc

fmadio@fmadio100v2-228U:/mnt/store0/lxc/lib/lxc$ sudo tar xfzv /mnt/store0/tmp2/public/container/centos7/fmadio_lxc_centos7.9.tar.gz | head
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
fmadio@fmadio100v2-228U:/mnt/store0/lxc/lib/lxc$
.
.
.
```


### STEP 4

Then follow the container specific instructions




