#!/bin/sh
set -e

until pg_isready -h $DB_HOST -p 5432 -U $DB_USER; do
  echo "Waiting for database..."
  sleep 2
done

mix ecto.create
mix ecto.migrate
mix phx.server