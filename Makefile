isDocker := $(shell docker info > /dev/null 2>&1 && echo 1)
domain := "application.fr"
server := "application@$(domain)"
user := $(shell id -u)
group := $(shell id -g)
dc := USER_ID=$(user) GROUP_ID=$(group) docker-compose
de := docker-compose exec
dr := $(dc) run --rm
sy := $(de) phpfpm bin/console
php := $(dr) --no-deps phpfpm
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Runs the docker-compose build command
	$(dc) build

.PHONY: start
start:  ## Start the development environment
	$(dc) up -d

.PHONY: stop
stop: ## Stop the development environment
	$(dc) down

.PHONY: symfony
symfony: ## Runs the installation of new symfony app (docker-compose up must be started)
	$(de) phpfpm symfony new . -q

.PHONY: asset
asset: ## install the assets (docker-compose up must be started)
	$(sy) asset:install -q

.PHONY: reset
reset: ## Reset the database (docker-compose up must be started)
	$(sy) doctrine:database:drop --force -q
	$(sy) doctrine:database:create -q
	$(sy) doctrine:migrations:migrate -q
	$(sy) doctrine:schema:validate -q
	$(sy) doctrine:fixtures:load -q

.PHONY: init
init: ## Initialize the database (docker-compose up must be started)
	$(sy) doctrine:database:create -q
	$(sy) doctrine:schema:create -q
	$(sy) doctrine:schema:validate -q

.PHONY: createdb
create_db: ## Creation of the database (docker-compose up must be started)
	$(sy) doctrine:database:create -q

.PHONY: deletedb
delete_db: ## Delete the database (docker-compose up must be started)
	$(sy) doctrine:database:drop --force -q

.PHONY: seed
seed: ## Generate data in the database (docker-compose up must be started)
	$(sy) doctrine:migrations:migrate -q
	$(sy) doctrine:schema:validate -q
	$(sy) doctrine:fixtures:load -q

.PHONY: migration
migration: ## Generates migrations
	$(sy) make:migration

.PHONY: migrate
migrate: ## Migrate the database (docker-compose up must be started)
	$(sy) doctrine:migrations:migrate -q

.PHONY: rollback
rollback:
	$(sy) doctrine:migration:migrate prev

.PHONY: install
composer: ## Runs the composer install command (docker-compose up must be started)
	$(de) phpfpm composer install -q

.PHONY: lint
lint: ## Analyse the code
	./vendor/bin/phpstan analyse

.PHONY: format
format: ## Format the code
	npx prettier-standard --lint --changed "assets/**/*.{js,css,jsx}"
	./vendor/bin/phpcbf
	./vendor/bin/php-cs-fixer fix

.PHONY: doc
doc: ## Generate the documentation summary
	npx doctoc ./README.md
