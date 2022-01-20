help:
	@awk 'BEGIN {FS = ":.*##"; printf "List of available commands (usage: make \033[36m<target>\033[0m):\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-13s\033[0m%s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

attach: ## Attach to the web service container
	@echo "Attached to the web container"
	@echo "Press CTRL-p CTRL-q key sequence to detach from a container and leave it running"
	docker attach m3p_1

bash: ## Start to the bash in web container
	docker-compose -f compose.development.yml exec web bash

build: ## Build the containers
	docker-compose -f compose.development.yml up --no-start --build --remove-orphans

bundle: ## Install ruby gems
	docker-compose -f compose.development.yml run --rm web bundle install

console: ## Start the Rails console
	docker-compose -f compose.development.yml exec web bin/rails console

containers_config: ## Validate containers configuration
	docker-compose -f compose.development.yml config

migrate: ## Migrate the database
	docker-compose -f compose.development.yml exec web bin/rails db:migrate

migrate_status: ## Display status of migrations
	docker-compose -f compose.development.yml exec web bin/rails db:migrate:status

restart: ## Display status of migrations
	docker-compose -f compose.development.yml restart

routes: ## Show list of the available routes
	docker-compose -f compose.development.yml exec web bin/rails routes

setup_databases: ## Drops and recreates all databases
	docker-compose -f compose.development.yml run --rm web bin/rails db:reset

start: ## Start the containers
	docker-compose -f compose.development.yml up

stop: ## Stop the containers
	docker-compose -f compose.development.yml stop

tests: ## Run tests through containers
	docker-compose -f compose.test.yml run web bundle exec rspec
