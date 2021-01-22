include .env

start: ## Start application
	$(info --> Start application)
	@docker network create ws-docker-network
	@docker run \
		--detach \
		--name ws-docker-mongo \
		--network=ws-docker-network \
		mongo:4
	@docker run \
		--rm \
		--detach \
		--name ws-docker-node \
		--network=ws-docker-network \
		--env-file "$(CURDIR)/.env" \
		--workdir "/srv/ws-docker" \
		--volume "$(CURDIR):/srv/ws-docker" \
		--publish ${PORT}:${PORT} \
		nicolasgrevin/node:15 bash -c "yarn && yarn start:dev"

stop: ## Stop application
	$(info --> Stop application)
	@docker rm --force --volumes ws-docker-mongo
	@docker rm --force --volumes ws-docker-node
	@docker network rm ws-docker-network

logs: ## Display logs
	$(info --> Display log)
	@docker logs --follow ws-docker-node

sudo-bash: ## Enter to interactive mode into container
	$(info --> Run ash inside the container app)
	@docker exec -u 0:0 --interactive --tty ws-docker-node bash

bash: ## Enter to interactive mode into container
	$(info --> Run ash inside the container app)
	@docker exec --interactive --tty ws-docker-node bash

build: ## Build container
	$(info --> Build container)
	@docker build --tag nicolasgrevin/node:15 .

.DEFAULT_GOAL := help

.PHONY:

HELP_FUNCTION = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); \
    print "  \033[0;33m$$_->[0]\033[0;37m$$sep\033[0;32m$$_->[1]\033[0;37m\n"; \
    }; \
    print "\n"; }

help: ##@other Show this help.
	@perl -e '$(HELP_FUNCTION)' $(MAKEFILE_LIST)

ERR = $(error found an error!)

err: ; $(ERR)
