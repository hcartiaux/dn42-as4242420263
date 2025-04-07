HOSTNAME=$(shell hostname)
DEST=$(shell pwd)/servers/$(HOSTNAME)
ID=$(shell whoami)
.PHONY: all bird wireguard net
all: bird wireguard net peeringdb

bird:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --no-links --exclude='roa' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.

wireguard:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(DEST)/$@/*.conf

net:
	mkdir -p $(DEST)/$@
	sudo cp /etc/systemd/resolved.conf $(DEST)/$@/
	sudo rsync --delete -av --exclude='resolved.conf' /etc/netplan/. $(DEST)/$@/.

peeringdb:
	mkdir -p $(DEST)/$@
	sudo cp /home/dn42-sshd/peering.db $(DEST)/$@/. || true
