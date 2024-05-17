FROM python:3.11-slim as base

WORKDIR /promo_site

RUN pip install poetry

COPY . .

# Tell poetry not to create a virtualenv so dependencies are installed system-wide
RUN poetry config virtualenvs.create false
# --no-ansi - no colors
RUN poetry install --no-root --no-interaction --no-ansi --no-cache

# Direct python to look for app module in the current directory
ENV PYTHONPATH=./

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]
