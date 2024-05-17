SHELL = /bin/bash

export PYTHONPATH=./
# Variables
POETRY = poetry
APP_FOLDER = promo_site/
APP_NAME = promo-site
DOCKER_COMPOSE_FILE=docker-compose -f docker-compose.yml
DOCKER_EXEC_APP=docker exec -it $(APP_NAME)-app
DOCKER_MIGRATIONS=$(DOCKER_EXEC_APP) $(POETRY) run python manage.py

# Commands
run:
	source .env && $(DOCKER_COMPOSE_FILE) up --build -d

run-python:
	$(POETRY) run python manage.py runserver

stop:
	$(DOCKER_COMPOSE_FILE) stop

logs:
	$(DOCKER_COMPOSE_FILE) logs -f

logs-app:
	docker logs -f $(APP_NAME)-app

exec-app:
	$(DOCKER_EXEC_APP) bash

test:
	$(POETRY) run pytest tests --maxfail=2 --cov-fail-under=90 --cov app -vv

migrations-new:
	@read -p "Enter migration message: " message; \
	$(DOCKER_MIGRATIONS) revision --autogenerate -m "$$message"

migrations-new-python:
	@read -p "Enter migration message: " message; \
	$(POETRY) run alembic revision --autogenerate -m "$$message"

migrations-up:
	$(DOCKER_MIGRATIONS) makemigrations

migrations-up-python:
	$(POETRY) run alembic upgrade head

migrations-down:
	$(DOCKER_MIGRATIONS) downgrade -1

migrations-down-python:
	$(POETRY) run alembic downgrade -1

format:
	$(POETRY) run black .
	$(POETRY) run isort .

lint:
	$(POETRY) run black --check .
	$(POETRY) run isort --check-only .
	$(POETRY) run flake8 $(APP_FOLDER)
	$(POETRY) run mypy $(APP_FOLDER)
