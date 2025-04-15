DN42 - AS4242420263 configuration
=================================

This repository contains is organized as follows:

* in `common`, common configuration files for all pop routers
* in `servers`, backup of each server specific configuration files (bird variables and peering sessions, wireguard configuration files, [autopeering service](https://github.com/hcartiaux/dn42-sshd-autopeer) database file `peering.db`)
* in `resources`: yed diagram and network weathermap configuration file

For general information, refer to the [AS4242420263 home page](https://hcartiaux.github.io/dn42/).  
For technical information about these configuration files, refer to [my blog posts tagged `dn42`](https://hcartiaux.github.io/tags/dn42/).

# Makefile

Use it to backup a pop router specific configuration

```
make all
```

