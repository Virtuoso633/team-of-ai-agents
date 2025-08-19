#!/bin/bash

# This script waits for the database to be ready before proceeding.
host=${DB_HOST:-db}
port=${DB_PORT:-5434}

echo "Waiting for database connection at $host:$port..."

# Use netcat (nc) to check if the port is open.
while ! nc -z $host $port; do
  echo "Database not ready yet. Retrying in 1 second..."
  sleep 1
done

echo "Database is available. Running migrations..."

# Now that the DB is ready, run migrations.
poetry run alembic upgrade head

echo "Migrations complete. Starting Uvicorn server..."
# Start the application.
exec uvicorn main:app --host 0.0.0.0 --port 4000 --reload