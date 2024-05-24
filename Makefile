CURDIR=$(shell pwd)
ID=$(shell whoami)
HOSTNAME=$(shell hostname)
.PHONY: all bird sysctl.d wireguard roa net
all: bird sysctl.d wireguard roa net

bird:
	sudo rsync --delete -av --exclude 'roa*' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.

roa:
	sudo cp /usr/local/bin/dn42-roa-update.sh $(CURDIR)/$@/.
	sudo cp /usr/local/bin/dn42-roa-update.sh $(CURDIR)/$@/.
	sudo cp /etc/systemd/system/dn42-roa.*    $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.

sysctl.d:
	sudo rsync --delete -av --exclude='README.sysctl' --exclude '99-sysctl.conf' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.

wireguard:
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(CURDIR)/$@/*.conf

net:
	mkdir -p  $(CURDIR)/$@/$(HOSTNAME)
	sudo rsync -av --exclude='50-cloud-init.yaml' /etc/netplan/. $(CURDIR)/$@/$(HOSTNAME)/.
	sudo cp /etc/systemd/resolved.conf $(CURDIR)/$@/$(HOSTNAME)/
	sudo chown -R $(ID): $(CURDIR)/$@/.
