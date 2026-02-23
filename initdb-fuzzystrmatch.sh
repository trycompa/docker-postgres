#!/bin/bash
set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Load pgvector into $POSTGRES_DB
echo "Loading fuzzystrmatch extension into $POSTGRES_DB"
psql --dbname="$POSTGRES_DB" -c 'CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;'