VERSION=alpine

up: build
	docker-compose -f ambari-server.yaml -f postgres.yaml -f ambari-agent.yaml -f local-repo.yaml up

down:
	docker-compose -f ambari-server.yaml -f postgres.yaml -f ambari-agent.yaml -f local-repo.yaml down

build: build-agent build-server

build-agent:
	docker build -t ambari-agent:centos6 ambari-agent/centos/6

build-server:
	docker build -t ambari-server:$(VERSION) ambari-server

.PHONY: build build-agent build-server up
