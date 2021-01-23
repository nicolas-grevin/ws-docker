include .env

start: ## Start application
	$(info --> Start application)
	@docker run \
		--rm \
		--detach \
		--name ws-docker \
		--env-file "$(CURDIR)/.env" \
		--workdir "/srv/ws-docker" \
		--volume "$(CURDIR):/srv/ws-docker" \
		--publish ${PORT}:${PORT} \
		nicolasgrevin/node:15 bash -c "yarn && yarn start:dev"

stop: ## Stop application
	$(info --> Stop application)
	@docker stop ws-docker

destroy: ## Stop and remove application
	$(info --> Stop and remove a running application)
	@docker rm --force --volumes ws-docker

logs: ## Display logs
	$(info --> Display log)
	@docker logs --follow ws-docker

bash: ## Enter to interactive mode into container
	$(info --> Run ash inside the container app)
	@docker exec -u 0:0 --interactive --tty ws-docker bash

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
