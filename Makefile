
.PHONY: install uninstall install-cluster install-app uninstall-cluster uninstall-app

install: install-cluster install-app

uninstall: uninstall-app uninstall-cluster

install-cluster:
	./install-cluster.sh

install-app:
	./install-app.sh

uninstall-cluster:
	./uninstall-cluster.sh

uninstall-app:
	./uninstall-app.sh