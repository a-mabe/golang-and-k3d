
.PHONY: install uninstall install-cluster install-app uninstall-cluster uninstall-app

install: install-cluster install-app

uninstall: uninstall-app uninstall-cluster

install-cluster:
	./scripts/install-cluster.sh

install-app:
	./scripts/install-app.sh

uninstall-cluster:
	./scripts/uninstall-cluster.sh

uninstall-app:
	./scripts/uninstall-app.sh