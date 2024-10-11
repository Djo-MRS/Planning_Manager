#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Ensure the app's database is created and migrations are run
echo "Checking for database..."
until pg_isready -h $DB_HOST -p 5432 -U $DB_USER; do
  echo "Waiting for database..."
  sleep 2
done

echo "Database is up! Running migrations..."

mix ecto.create
mix ecto.migrate

# Run the Phoenix server
exec "$@"