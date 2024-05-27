HOSTNAME=$(shell hostname)
DEST=$(shell pwd)/$(HOSTNAME)
ID=$(shell whoami)
.PHONY: all bird sysctl.d wireguard roa net
all: bird sysctl.d wireguard roa net

bird:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --exclude 'roa*' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.

roa:
	mkdir -p $(DEST)/$@
	sudo cp /usr/local/bin/dn42-roa-update.sh $(DEST)/$@/.
	sudo cp /usr/local/bin/dn42-roa-update.sh $(DEST)/$@/.
	sudo cp /etc/systemd/system/dn42-roa.*    $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.

sysctl.d:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --exclude='README.sysctl' --exclude '99-sysctl.conf' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.

wireguard:
	mkdir -p $(DEST)/$@
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(DEST)/$@/.
	sudo chown -R $(ID): $(DEST)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(DEST)/$@/*.conf

net:
	mkdir -p $(DEST)/$@
	mkdir -p  $(DEST)/$@/$(HOSTNAME)
	sudo rsync -av --exclude='50-cloud-init.yaml' /etc/netplan/. $(DEST)/$@/.
	sudo cp /etc/systemd/resolved.conf $(DEST)/$@/
	sudo chown -R $(ID): $(DEST)/$@/.
