include .env

build: ## Build container
	$(info --> Build container)
	@docker build --target prod --tag nicolasgrevin/app:prod .

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
