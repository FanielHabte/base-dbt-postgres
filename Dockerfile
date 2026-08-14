FROM python:3.12.13-slim
LABEL author="Fani Habte"

COPY --from=ghcr.io/astral-sh/uv:0.5.11 /uv /usr/local/bin/uv

ENV UV_PROJECT_ENVIRONMENT=/opt/venv \
    DBT_PACKAGES_INSTALL_PATH=/opt/dbt_packages \
    DBT_PROFILES_DIR=/usr/app/dbt \
    PATH="/opt/venv/bin:$PATH"

WORKDIR /build
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

WORKDIR /usr/app/dbt
ENTRYPOINT ["dbt"]