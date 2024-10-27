FROM elixir:1.14.5-alpine AS app

RUN apk add --no-cache \
    build-base \
    bash \
    postgresql-client \
    openssl-dev

WORKDIR /app

COPY . .

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix compile
RUN apk add --no-cache inotify-tools


EXPOSE 4000

ENTRYPOINT ["sh", "/app/entrypoint.sh"]
