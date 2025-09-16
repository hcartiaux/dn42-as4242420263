HOSTNAME=$(shell hostname -s)
DEST=$(shell pwd)/servers/$(HOSTNAME)
ID=$(shell whoami)
.PHONY: all bird wireguard etc peeringdb
all: bird wireguard etc peeringdb

bird:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --no-links --exclude='roa' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.

wireguard:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(DEST)/$@/*.conf || true

etc:
	mkdir -p $(DEST)/$@/systemd
	mkdir -p $(DEST)/$@/netplan
	mkdir -p $(DEST)/$@/network
	sudo cp /etc/systemd/resolved.conf $(DEST)/$@/systemd/ 2>/dev/null || true
	sudo cp /etc/resolv.conf $(DEST)/$@/ 2>/dev/null || true
	sudo rsync --delete -av /etc/netplan/. $(DEST)/$@/netplan/. 2>/dev/null || true
	sudo cp /etc/network/interfaces $(DEST)/$@/network/ 2>/dev/null || true
	sudo rsync --delete -av /etc/network/interfaces.d/. $(DEST)/$@/network/interfaces.d/. 2>/dev/null || true
	sudo chown -R $(ID): $(DEST)/$@/.

peeringdb:
	mkdir -p $(DEST)/$@
	sudo cp /home/dn42-sshd/peering.db $(DEST)/$@/. || true
