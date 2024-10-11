FROM elixir:alpine AS app

WORKDIR /app

RUN apk add --no-cache postgresql-client git build-base bash

COPY . .

RUN mix local.hex --force && mix local.hex --force
RUN mix deps.get
RUN mix do compile

EXPOSE 4000

ENTRYPOINT ["sh", "/app/entrypoint.sh"]