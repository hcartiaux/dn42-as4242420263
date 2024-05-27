DN42 - AS4242420263 configuration
=================================

# Makefile

Use it to backup a pop router configuration

```
make all
```

# Wireguard

```
apt install wireguard
cd /etc/wireguard/
umask 077; wg genkey | tee privatekey | wg pubkey > publickey
```

# Bird

```
apt install bird2
```

# ROA set-up

```
systemctl enable --now dn42-roa.timer

systemctl list-timers
NEXT                         LEFT          LAST                         PASSED        UNIT                         ACTIVATES
Mon 2024-05-20 23:38:26 CEST 46s left      Mon 2024-05-20 23:23:26 CEST 14min ago     dn42-roa.timer               dn42-roa.service
```
