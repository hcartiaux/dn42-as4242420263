CURDIR=$(shell pwd)
ID=$(shell whoami)

.PHONY: all bird sysctl.d wireguard roa net
all: bird sysctl.d wireguard roa net

bird:
	sudo rsync --delete -av --exclude 'roa*' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/bird/.

roa:
	sudo cp /usr/local/bin/dn42-roa-update.sh $(CURDIR)/$@/.
	sudo cp /usr/local/bin/dn42-roa-update.sh $(CURDIR)/$@/.
	sudo cp /etc/systemd/system/dn42-roa.*    $(CURDIR)/$@/.

sysctl.d:
	sudo rsync --delete -av --exclude='README.sysctl' --exclude '99-sysctl.conf' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.

wireguard:
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(CURDIR)/$@/*.conf

net:
	sudo cp /etc/netplan/99-dn42.yaml $(CURDIR)/$@/$(shell hostname)_99-dn42.yaml
