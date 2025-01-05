HOSTNAME=$(shell hostname)
DEST=$(shell pwd)/servers/$(HOSTNAME)
ID=$(shell whoami)
.PHONY: all bird wireguard
all: bird wireguard

bird:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --include 'variables.conf' --include 'bgp_peers' --exclude '*' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.

wireguard:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(DEST)/$@/*.conf

net:
	sudo cp /etc/systemd/resolved.conf $(DEST)/$@/
	sudo rsync --delete -av --exclude='resolved.conf' /etc/netplan/. $(DEST)/$@/.


