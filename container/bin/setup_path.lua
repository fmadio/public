#!/usr/local/bin/luajit

-- setup the lxc paths
os.execute("mkdir -p /mnt/store0/lxc/cache")
os.execute("mkdir -p /mnt/store0/lxc/log")
os.execute("mkdir -p /mnt/store0/lxc/lock")
os.execute("mkdir -p /mnt/store0/lxc/lib/lxc")
