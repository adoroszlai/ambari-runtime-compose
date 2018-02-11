VERSION=dev

build:
	docker build -t ambari-server:$(VERSION) ambari-server

.PHONY: build
