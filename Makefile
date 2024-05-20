CURDIR=$(shell pwd)
ID=$(shell whoami)

.PHONY: all bird sysctl.d wireguard
all: bird sysctl.d wireguard

bird:
	sudo rsync --delete -av --exclude 'roa*' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/bird/.

sysctl.d:
	sudo rsync --delete -av --exclude='README.sysctl' --exclude '99-sysctl.conf' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.

wireguard:
	sudo rsync --delete -av --include='*.conf' --exclude='*' /etc/$@/. $(CURDIR)/$@/.
	sudo chown -R $(ID): $(CURDIR)/$@/.
	sed -i 's/PrivateKey =.*$$/PrivateKey = /g' $(CURDIR)/$@/*.conf
