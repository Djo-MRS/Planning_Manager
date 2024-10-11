# Stage 2: Create the release and package it for production
FROM elixir:1.14-alpine AS app

WORKDIR /app

# Install the postgresql-client for database communication
RUN apk add --no-cache postgresql-client git build-base bash


COPY . .
RUN mix local.hex --force
RUN mix deps.get
RUN mix local.rebar --force
RUN mix do compile

# Expose the port the Phoenix app runs on
EXPOSE 4000

# Entry point script to prepare the database and run the server
ENTRYPOINT ["sh", "/app/entrypoint.sh"]

# Default command to run the Phoenix app
CMD ["mix", "phx.server"]