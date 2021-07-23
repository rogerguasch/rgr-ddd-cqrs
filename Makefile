current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

#*********** DATABASE ***********#
.PHONY: go_mysql
go_mysql:
	@echo "Going inside MySql..."
	@docker exec -it rgr_api_bbdd mysql --user=user --password=password

.PHONY: create-database
create-database:
	@echo "Creating the database..."
	@docker exec rgr_api php bin/console doctrine:database:create

.PHONY: migrations
migrations:
	@echo "Migrations..."
	@docker exec rgr_api php bin/console doctrine:migrations:migrate

.PHONY: ping-mysql
ping-mysql:
	@docker exec rgr_api_bbdd mysqladmin --user=user --password=password --host "127.0.0.1" ping --silent

.PHONY: docker-status
docker-status:
	@docker-compose ps

.PHONY: docker-down
docker-down:
	@docker-compose down

.PHONY: docker-up
docker-up:
	@docker-compose up -d
